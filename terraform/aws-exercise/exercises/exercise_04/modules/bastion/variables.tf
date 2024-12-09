variable "ami_id" {
    description = "The AMI ID to use for the bastion instance"
    type        = string
    default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
    description = "The instance type to use for the bastion instance"
    type        = string
    default = "t2.micro"
}

variable "key_pair_path" {
    description = "The key pair path to use for the launch template"
    type        = string
}

variable "sg_bastion" {
    description = "The security groups to use for the bastion instance"
    type        = list(string)
}

variable "subnet_id" {
    description = "The subnet ID to use for the bastion instance"
    type        = string
}
