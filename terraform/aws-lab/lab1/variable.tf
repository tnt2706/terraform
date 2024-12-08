variable "instance_type" {
  type = string
  description = "value of instance type"
  default = "t2.micro"
}

variable "region" {
  type = string
  description = "value of region"
  default = "us-east-2"
}

variable "aims" {
    type = map(any)
   default = {
    "us-east-2" = "ami-0c55b159cbfafe1f0"
    "us-west-1" = "ami-0c55b159cbfafe1f0"
    "us-west-2" = "ami-0c55b159cbfafe1f0"
    "eu-west-1" = "ami-0c55b159cbfafe1f0"
    "eu-west-2" = "ami-0c55b159cbfafe1f0"
    "eu-west-3" = "ami-0c55b159cbfafe1f0"
    "eu-central-1" = "ami-0c55b159cbfafe1f0"
    "ap-south-1" = "ami-0c55b159cbfafe1f0"
    "ap-southeast-1" = "ami-0c55b159cbfafe1f0"
    "ap-southeast-2" = "ami-0c55b159cbfafe1f0"
    "ap-northeast-1" = "ami-0c55b159cbfafe1f0"
    "ap-northeast-2" = "ami-0c55b159cbfafe1f0"
    "sa-east-1" = "ami-0c55b159cbfafe1f0"
   }
}

