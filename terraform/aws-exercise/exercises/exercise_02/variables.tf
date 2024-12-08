variable "region" {
  type    = string
  default = "us-east-2"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "my-vpc"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones"
  default = [
    "us-east-2a",
    "us-east-2b",
  ]
}


variable "key_pair_path" {
  type        = string
  description = "Path to the key pair"
  default     = "../../aws-key/tran-ngoc-tinh.pub"
}

variable "public_subnet_ips" {
  type        = list(string)
  description = "List of public subnet IDs"
  default = [
    "10.0.4.0/22",
    "10.0.12.0/22",
  ]
}

variable "private_subnet_ips" {
  type        = list(string)
  description = "List of public subnet IDs"
  default = [
    "10.0.8.0/22",
    "10.0.16.0/22",
  ]
}


variable "ami" {
  type        = string
  description = "The aim of the exercise"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  type        = string
  description = "The instance type"
  default     = "t2.micro"
}

variable "desired_capacity" {
  type        = number
  description = "The desired capacity of the autoscaling group"
  default     = 2
}

