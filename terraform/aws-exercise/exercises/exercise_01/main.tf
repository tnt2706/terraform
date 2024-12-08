terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tran_ngoc_tinh" {
  key_name   = "tran-ngoc-tinh"
  public_key = file(var.key_pair_path)
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = var.private_subnet_ips
  public_subnets  = var.public_subnet_ips

  enable_nat_gateway = false
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "webserver" {
  name        = "Webserver"
  description = "Webserver network traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow traffic"
  }
}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tran_ngoc_tinh.key_name
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.webserver.id]

  associate_public_ip_address = true

  tags = {
    Name = "EC2 Exercise"
  }
}
