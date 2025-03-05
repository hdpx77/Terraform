provider "aws" {
  region = "us-east-1"  
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}
resource "aws_subnet" "public" {
  count             = 3
  vpc_id           = aws_vpc.main.id
  cidr_block       = "10.0.${count.index}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = 3
  vpc_id           = aws_vpc.main.id
  cidr_block       = "10.0.${count.index + 10}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
}
