resource "aws_vpc" "tf-vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "tf-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.subnet1cidr

  tags = {
    Name = "public-subnet1"
    Environment = var.environment
  }
}

resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "route1"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.route1.id
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "a"
    Environment = var.environment
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.subnet2cidr

  tags = {
    Name = "public-subnet2"
    Environment = var.environment
  }
}

resource "aws_route_table" "route2" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "route2"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.route2.id
}


resource "aws_security_group" "security-group1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.tf-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
    Environment = var.environment
  }
}