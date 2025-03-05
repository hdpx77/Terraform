region = "us-west-2"

vpc_cidr = "10.1.0.0/16"

public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
private_subnets = ["10.1.11.0/24", "10.1.12.0/24", "10.1.13.0/24"]

instance_type = "t2.micro"

ami_id = "ami-027951e78de46a00e"  
ssh_ingress_cidr = "192.168.1.0/24"
http_ingress_cidr = "0.0.0.0/0"
