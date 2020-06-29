variable "aws_region" {
  default = "us-east-2"
}

variable "amis" {
  type = map(string)
  default = {
    us-east-2 = "ami-026dea5602e368e96"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "VPC-CIDR" {
  type    = string
  default = "10.0.0.0/16"
}

variable "publicSubnet-CIDR" {
  type    = string
  default = "10.0.1.0/24"
}

variable "privateSubnet-CIDR" {
  type    = string
  default = "10.0.2.0/24"
}

variable "key_path" {
  default = "vpcKey.pub"
}
