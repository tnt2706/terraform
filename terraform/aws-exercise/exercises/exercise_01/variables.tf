variable "region" {
  type = string
  default = "us-east-2"
}

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
  ]
}

variable "private_subnet_ips" {
  type = list(string)
  description = "List of private subnet IDs"
  default = [
    "10.0.1.0/24", 
    "10.0.2.0/24"
    ]
}

variable "public_subnet_ips" {
  type = list(string)
  description = "List of public subnet IDs"
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24"
    ]
}

variable "key_pair_path" {
    type = string
    description = "Path to the key pair"
    default = "../../aws-key/tran-ngoc-tinh.pub"
}

variable "ami" {
    type = string
    description = "AMI ID"
    default = "ami-0c55b159cbfafe1f0"
}