provider "aws" {
  region = var.region
}

resource "aws_key_pair" "tran-ngoc-tinh" {
  key_name   = "tran-ngoc-tinh"
  public_key = file("../aws-key/tran-ngoc-tinh.pub")
}

resource "aws_eip" "demo-eip" {
  instance = aws_instance.example.id
}

resource "aws_instance" "example" {
  ami           = var.aims[var.region]
  instance_type = var.instance_type

  key_name = aws_key_pair.tran-ngoc-tinh.key_name

  tags = {
    Name = "MyEC2Instance"
  }
}


output "instance_ip_addr_public" {
  value = aws_instance.example.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.example.private_ip
}

output "eip_public_ip" {
  value = aws_eip.demo-eip.public_ip
}


