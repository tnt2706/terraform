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
