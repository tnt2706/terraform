provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tran-ngoc-tinh" {
  key_name   = "tran-ngoc-tinh"
  public_key = file(var.key_pair_path)
}

module "network" {
  source = "./modules/network"
  region = var.region
}

# module "compute" {
#   source = "./modules/compute"
#   region = var.region
#   image_id = var.amis[var.region]
#   key_name = aws_key_pair.tran-ngoc-tinh.key_name
#   instance_type = var.instance_type
#   ec2_security_group_ids = [module.network.public_security_group_id]
# }
