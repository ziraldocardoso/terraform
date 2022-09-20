provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-0729e439b6769d6ab"
  instance_type = "t2.micro"
tags = {
    Name = "terraform-example21"
  }
}
