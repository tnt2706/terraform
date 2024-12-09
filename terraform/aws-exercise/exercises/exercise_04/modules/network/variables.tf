
variable "vpc_name" {
  type = string
  description = "Name of the VPC"
  default = "my-vpc"
}

variable "azs" {
  type = list(string)
  description = "List of availability zones"
  default = [
    "us-east-2a",
    "us-east-2b",
  ]
}

variable "public_subnet_ips" {
  type = list(string)
  description = "List of public subnet IDs"
  default = [
    "10.0.4.0/22",
    "10.0.12.0/22",
  ]
}

variable "private_subnet_ips" {
  type = list(string)
  description = "List of public subnet IDs"
  default = [
    "10.0.8.0/22",
    "10.0.16.0/22",
  ]
}