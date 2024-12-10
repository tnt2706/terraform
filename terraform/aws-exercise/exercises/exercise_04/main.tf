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

module "application" {
  source             = "./modules/application"
  public_subnet_ids  = module.network.public_subnets
  private_subnet_ids = module.network.private_subnets
  vpc_id             = module.network.vpc_id
  key_pair_path      = aws_key_pair.tran_ngoc_tinh.key_name
  sg_application     = [module.security_groups.sg_application]
  alb_target_group   = module.load_balancer.target_group_arn
  sg_elb             = [module.security_groups.sg_elb]
  azs                = var.azs
  mongodb_ip = module.database.private_ip
}
