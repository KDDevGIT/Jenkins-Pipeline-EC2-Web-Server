variable "aws_region" {
  description = "AWS Region to Deploy"
  type = string
  default = "us-west-1"
}

variable "environment" {
  description = "Environment Name"
  type = string
}

variable "instance_type" {
  description = "EC2 Instance Type for Web Server"
  type = string
  default = "t3.micro"
}

variable "allowed_http_cidrs" {
  description = "CIDR Blocks allowed to reach HTTP on the instance"
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "key_name" {
  description = "Optional EC2 Key Pair Name for SSH"
  type = string
  default = null
}

