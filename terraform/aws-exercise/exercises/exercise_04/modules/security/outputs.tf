output "sg_public" {
  value = aws_security_group.public_security_group.id
}

output "sg_private" {
  value = aws_security_group.private_security_group.id
}

output "sg_elb" {
  value = aws_security_group.sg_elb.id
}

output "sg_backend" {
  value = aws_security_group.sg_backend.id
}

output "sg_fontend" {
  value = aws_security_group.sg_fontend.id
}

output "sg_bastion" {
  value = aws_security_group.sg_bastion.id
}

output "sg_database" {
  value = aws_security_group.sg_database.id
}