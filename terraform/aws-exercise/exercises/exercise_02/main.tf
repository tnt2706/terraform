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

module "network" {
  source             = "./modules/network"
  vpc_name           = var.vpc_name
  private_subnet_ips = var.private_subnet_ips
  public_subnet_ips  = var.public_subnet_ips
  azs                = var.azs
}


module "security" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "load_balancer" {
  source                   = "./modules/load_balancer/"
  alb-security_groups      = [module.security.alb_security_group]
  public_subnet_ids        = module.network.public_subnets
  azs                      = var.azs
  aws_lb-target_group-name = "elb-target-group"
  vpc_id                   = module.network.vpc_id
}

module "compute" {
  source                   = "./modules/compute"
  ami_id                   = var.ami
  instance_type            = var.instance_type
  instance-security_groups = [module.security.instance_security_group]
  desired_capacity         = var.desired_capacity
  private_subnet_ids       = module.network.private_subnets
  vpc_id                   = module.network.vpc_id
  key_pair_path            = aws_key_pair.tran_ngoc_tinh.key_name
  alb_target_group         = module.load_balancer.alb_target_group
}
