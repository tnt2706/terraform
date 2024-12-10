terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

resource "aws_instance" "database" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_path
  vpc_security_group_ids = var.sg_database
  subnet_id = var.subnet_id

  user_data = filebase64("${path.module}/install.sh")

  tags = {
    Name = "database"
  }
}