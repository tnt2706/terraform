variable "region" {
  type = string
  default = "us-east-2"
}
variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Example: t2.micro"
  default = "t3.micro"
}
variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-0e4b5d31e60aa0acd"
    "ap-northeast-1" : "ami-0dfa284c9d7b2adad"
    "us-east-2" : "ami-0c55b159cbfafe1f0"
  }
}
variable "key_pair_path" {
  type = string
  default = "../aws-key/tran-ngoc-tinh.pub" 
}