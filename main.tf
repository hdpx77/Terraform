provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
 count             = length(var.public_subnets)
  vpc_id           = aws_vpc.main.id
  cidr_block       = var.public_subnets[count.index]
  availability_zone = element(["eu-north-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id           = aws_vpc.main.id
  cidr_block       = var.private_subnets[count.index]
  availability_zone = element(["eu-north-1a", "eu-north-1b"], count.index)
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.http_ingress_cidr]
  }
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ingress_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "my-security-group"
  }

}
resource "aws_instance" "nginx" {
  count          = length(var.public_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public[count.index].id
  security_groups = [aws_security_group.my_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-Instance"
  }
}


