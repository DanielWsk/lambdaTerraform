resource "aws_vpc" "tf-vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "tf-vpc"
    Environment = var.environment
  }
}

resource "aws_eip" "elasticip" {
  depends_on = [aws_internet_gateway.igw1]
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = aws_subnet.publicsubnet1.id

  depends_on = [aws_internet_gateway.igw1]

  tags = {
    Name = "natgw"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "igw"
    Environment = var.environment
  }
}

resource "aws_subnet" "publicsubnet1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.pubsubnet1cidr

  tags = {
    Name = "public-subnet1"
    Environment = var.environment
  }
}

resource "aws_route_table" "pubroute1" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "pubroute1"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "rtapub1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.pubroute1.id
}

resource "aws_subnet" "publicsubnet2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.pubsubnet2cidr

  tags = {
    Name = "public-subnet2"
    Environment = var.environment
  }
}

resource "aws_route_table" "pubroute2" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "pubroute2"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "rtapub2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.pubroute2.id
}

resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.privsubnet1cidr

  tags = {
    Name = "private-subnet1"
    Environment = var.environment
  }
}

resource "aws_route_table" "privroute1" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "privroute1"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "rtapriv1" {
  subnet_id      = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.privroute1.id
}

resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.privsubnet2cidr

  tags = {
    Name = "private-subnet2"
    Environment = var.environment
  }
}

resource "aws_route_table" "privroute2" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "privroute2"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "rtapriv2" {
  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privroute2.id
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