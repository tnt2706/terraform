variable "alb-security_groups" {
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

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}