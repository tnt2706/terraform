resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_path
  vpc_security_group_ids = var.sg_bastion
  subnet_id              = var.subnet_id

  root_block_device {
    volume_size = 10
    encrypted   = true
  }

  tags = {
    Name = "bastion"
  }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
}
