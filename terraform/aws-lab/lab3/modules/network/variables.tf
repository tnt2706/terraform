variable "region" {
  type = string
  default = "us-east-2"
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