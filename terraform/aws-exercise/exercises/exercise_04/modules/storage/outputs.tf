output "db_private_ip" {
  value = aws_instance.database.public_ip
}