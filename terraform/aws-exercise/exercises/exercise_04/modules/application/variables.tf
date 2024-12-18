variable "instance_type" {
    description = "The instance type to use for the launch template"
    type        = string
    default = "t2.micro"
}

variable "desired_capacity" {
    description = "The desired capacity of the autoscaling group"
    type        = number
    default = 2
}

variable "max_size" {
    description = "The maximum size of the autoscaling group"
    type        = number
    default = 2
}

variable "min_size" {
    description = "The minimum size of the autoscaling group"
    type        = number
    default = 2
}


variable "private_subnet_ids" {
    description = "The private subnet IDs to use for the autoscaling group"
    type        = list(string)
}

variable "vpc_id" {
    description = "The VPC ID to use for the autoscaling group"
    type        = string
}

variable "key_pair_path" {
    description = "The key pair path to use for the launch template"
    type        = string
}

variable "sg_application" {
    description = "The security groups to use for the launch template"
    type        = list(string)
}

variable "sg_elb" {
  type        = list(string)
  description = "List of security groups"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The ID of the subnet"
}

variable "azs" {
  type        = list(string)
  description = "The aim of the exercise"
  default = [
    "ami-0c55b159cbfafe1f0"
  ]
}

variable "aws_lb-name" {
  type        = string
  description = "The name of the load balancer"
  default     = "nginx-alb"
}

variable "aws_lb-target_group-name" {
  type        = string
  description = "The name of the target group"
  default     = "nginx-target-group"
  
}

variable "mongodb_ip" {
  type        = string
  description = "The IP of the MongoDB instance"
}


variable "instance-security_groups" {
    description = "The target group ARN to use for the autoscaling group"
    type        = string
}