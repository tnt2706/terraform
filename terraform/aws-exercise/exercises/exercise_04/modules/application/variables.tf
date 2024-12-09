variable "ami_id" {
    description = "The AMI ID to use for the launch template"
    type        = string
    default = "ami-0c55b159cbfafe1f0"
}

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

variable "alb_target_group" {
    description = "The target group ARN to use for the autoscaling group"
    type        = string
}