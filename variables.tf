variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Machine Image ID for EC2 instances"
  default     = "ami-027951e78de46a00e" 
}

variable "ssh_ingress_cidr" {
  description = "Allowed CIDR block for SSH access"
  default     = "0.0.0.0/0"
}

variable "http_ingress_cidr" {
  description = "Allowed CIDR block for HTTP access"
  default     = "0.0.0.0/0"
}
