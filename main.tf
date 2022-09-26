provider "aws" {
  region = "us-east-1"
}
##################################################################
# EC2 instance
##################################################################
resource "aws_instance" "varnish-cache" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
  tags = {
    Name = "varnish-cache"
    }
  vpc_security_group_ids = [aws_security_group.instance.id]
}
resource "aws_instance" "magento-app" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
  tags = {
    Name = "magento-app"
    }
  vpc_security_group_ids = [aws_security_group.instance.id]
}
##################################################################
# application load balancer
##################################################################
resource "aws_lb_target_group" "varnish-cache-http" {
  name     = "varnish-cache-http"
  port     = var.http_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.block.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/health_check.php"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 3
  }
}
##################################################################
resource "aws_lb_target_group_attachment" "varnish-cache-http" {
  target_group_arn = aws_lb_target_group.varnish-cache-http.arn
  target_id        = aws_instance.varnish-cache.id
  port             = var.http_port
}
##################################################################
resource "aws_lb" "application" {
  name               = "application-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.private-1a.id, aws_subnet.private-1b.id, aws_subnet.private-1c.id, aws_subnet.private-1d.id, aws_subnet.private-1e.id, aws_subnet.private-1f.id]
  enable_deletion_protection = false
}
##################################################################
resource "aws_lb_listener" "cache-http" {
  load_balancer_arn = aws_lb.application.arn
  port              = var.http_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.varnish-cache-http.arn
  }
}
resource "aws_lb_listener" "cache-https" {
  load_balancer_arn = aws_lb.application.arn
  port              = var.https_port
  protocol          = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.varnish-cache-http.arn
  }
}
##################################################################
# network load balancer 
##################################################################
resource "aws_lb_target_group" "app-load-balancer-http" {
  name        = "app-load-balancer-http"
  port        = var.http_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.block.id
  target_type = "alb"
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200-399
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 3
  }
}
resource "aws_lb_target_group" "app-load-balancer-https" {
  name        = "app-load-balancer-https"
  port        = var.https_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.block.id
  target_type = "alb"
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200-399
    path = "/"
    port = "traffic-port"
    protocol = "HTTPS"
    timeout = 3
    unhealthy_threshold = 3
  }
}
##################################################################
resource "aws_lb_target_group_attachment" "app-load-balancer-http" {
    target_group_arn = aws_lb_target_group.app-load-balancer-http.arn
    target_id        = aws_lb.application.arn
    port             = var.http_port
}
resource "aws_lb_target_group_attachment" "app-load-balancer-https" {
    target_group_arn = aws_lb_target_group.app-load-balancer-https.arn
    target_id        = aws_lb.application.arn
    port             = var.https_port
}
##################################################################
resource "aws_lb" "network" {
  name               = "network-load-balancer"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.lb.id]
  subnets            = [aws_subnet.private-1a.id, aws_subnet.private-1b.id, aws_subnet.private-1c.id, aws_subnet.private-1d.id, aws_subnet.private-1e.id, aws_subnet.private-1f.id]
  enable_deletion_protection = false
}
##################################################################
resource "aws_lb_listener" "alb-http" {
  load_balancer_arn = aws_lb.network.arn
  port              = var.http_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-load-balancer-http.arn
  }
}
resource "aws_lb_listener" "alb-https" {
  load_balancer_arn = aws_lb.network.arn
  port              = var.https_port
  protocol          = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-load-balancer-https.arn
  }
}
##################################################################
