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

module "security_groups" {
  source = "./modules/security"
  vpc_id = module.network.vpc_id
}

module "bastion" {
  source        = "./modules/bastion"
  ami_id        = var.ami
  instance_type = var.instance_type
  subnet_id     = module.network.public_subnets[0]
  key_pair_path = aws_key_pair.tran_ngoc_tinh.key_name
  sg_bastion    = [module.security_groups.sg_bastion]
}

module "database" {
  source        = "./modules/storage"
  ami_id        = var.ami
  instance_type = var.instance_type
  subnet_id     = module.network.private_subnets[0]
  key_pair_path = aws_key_pair.tran_ngoc_tinh.key_name
  sg_database   = [module.security_groups.sg_database]
}

# module "application" {
#   source             = "./modules/application"
#   ami_id             = var.ami
#   vpc_id             = module.network.vpc_id
#   instance_type      = var.instance_type
#   key_pair_path      = aws_key_pair.tran_ngoc_tinh.key_name
#   sg_application     = [module.security_groups.sg_backend, module.security_groups.sg_fontend]
#   alb_target_group   = module.load_balancer.alb_target_group
#   private_subnet_ids = module.network.private_subnets
# }


# module "load_balancer" {
#   source                   = "./modules/load_balancer/"
#   key_pair_path            = aws_key_pair.tran_ngoc_tinh.key_name
#   sg_elb      = module.security_groups.sg_elb
#   public_subnet_ids        = module.network.public_subnets
#   azs                      = var.azs
#   vpc_id                   = module.network.vpc_id
#   mongodb_ip               = module.database.private_ip
#   instance-security_groups = [module.security_groups.sg_backend, module.security_groups.sg_fontend]
#   private_subnet_ids       = module.network.private_subnets
#   alb_target_group         = "alb-target-group"
# }
