variable "aws_region" {
  default = "us-east-2"
}

variable "aws_availability_zone" {
  default = "us-east-2a"
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

variable "key_path" {
  default = "mykey.pub"
}
