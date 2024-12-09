module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = var.vpc_name
  cidr                 = "10.0.0.0/16"
  azs                  = var.azs
  private_subnets      = var.private_subnet_ips
  public_subnets       = var.public_subnet_ips
  enable_nat_gateway   = true
  enable_vpn_gateway   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}