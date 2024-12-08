output "instance_ip_addr_public" {
  value = module.compute.instance_ip_addr_public
}

output "instance_ip_addr_private" {
  value = module.compute.instance_ip_addr_private
}

output "public_security_group_id" {
  value = module.network.public_security_group_id
}
output "private_security_group_id" {
  value = module.network.private_security_group_id
}