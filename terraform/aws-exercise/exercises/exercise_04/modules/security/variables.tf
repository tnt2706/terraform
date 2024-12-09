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


variable "sg_backend_security_group_name" {
  type        = string
  description = "Backed Security Group Name"
  default     = "sg_backend"
  
}

variable "sg_fontend_security_group_name" {
  type        = string
  description = "Fontend Security Group Name"
  default     = "sg_fontend"
}

variable "sg_bastion_security_group_name" {
  type        = string
  description = "Bastion Security Group Name"
  default     = "sg_bastion"
}

variable "sg_database_security_group_name" {
  type        = string
  description = "Database Security Group Name"
  default     = "sg_database"
}