output "public_security_group" {
  value = aws_security_group.public_security_group.id
}

output "private_security_group" {
  value = aws_security_group.private_security_group.id
}


output "alb_security_group" {
  value = aws_security_group.elb.id
}

output "instance_security_group" {
  value = aws_security_group.instance.id
}