resource "aws_default_vpc" "block" {
  #cidr_block = "172.31.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_default_subnet" "private-1a" {
  availability_zone = "us-east-1a"
}
resource "aws_default_subnet" "private-1b" {
  availability_zone = "us-east-1b"
}
resource "aws_default_subnet" "private-1c" {
  availability_zone = "us-east-1c"
}
resource "aws_default_subnet" "private-1d" {
  availability_zone = "us-east-1d"
}
resource "aws_default_subnet" "private-1e" {
  availability_zone = "us-east-1e"
}
resource "aws_default_subnet" "private-1f" {
  availability_zone = "us-east-1f"
}
/* resource "aws_subnet" "private-1a" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.16.0/20"
  availability_zone = "us-east-1a"
}
resource "aws_subnet" "private-1b" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.32.0/20"
  availability_zone = "us-east-1b"
}
resource "aws_subnet" "private-1c" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "us-east-1c"
}
resource "aws_subnet" "private-1d" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.80.0/20"
  availability_zone = "us-east-1d"
}
resource "aws_subnet" "private-1e" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.48.0/20"
  availability_zone = "us-east-1e"
}
resource "aws_subnet" "private-1f" {
  vpc_id            = aws_default_vpc.block.id
  cidr_block        = "172.31.64.0/20"
  availability_zone = "us-east-1f"
} */
##################################################################
/* resource "aws_route_table" "block-rt" {
  vpc_id = aws_default_vpc.block.id
} */
##################################################################
/* resource "aws_route_table_association" "private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.block-rt.id
}
resource "aws_route_table_association" "private-1b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.block-rt.id
}
resource "aws_route_table_association" "private-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.block-rt.id
}
resource "aws_route_table_association" "private-1d" {
  subnet_id      = aws_subnet.private-1d.id
  route_table_id = aws_route_table.block-rt.id
}
resource "aws_route_table_association" "private-1e" {
  subnet_id      = aws_subnet.private-1e.id
  route_table_id = aws_route_table.block-rt.id
}
resource "aws_route_table_association" "private-1f" {
  subnet_id      = aws_subnet.private-1f.id
  route_table_id = aws_route_table.block-rt.id
} */
##################################################################
/* resource "aws_internet_gateway" "block-igw" {
  vpc_id = aws_default_vpc.block.id
} */
##################################################################
/* resource "aws_route" "internet-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.block-rt.id
  gateway_id             = aws_internet_gateway.block-igw.id
} */
