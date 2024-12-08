variable "vpc_id" {
  type        = string
  description = "VPC ID"

}

variable "public_security_group_name" {
  type        = string
  description = "Public Security Group Name"
  default     = "public_security_group"
}


variable "private_security_group_name" {
  type        = string
  description = "Private Security Group Name"
  default     = "private_security_group"
}


variable "alb_security_group_name" {
  type        = string
  description = "alb Security Group Name"
  default     = "alb"
}


variable "instance_security_group_name" {
  type        = string
  description = "Instance Security Group Name"
  default     = "instance-sg"
  
}