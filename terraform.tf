terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

locals {

  VPC_name = "mylocalVPC"

}

output "VPC_ID" {
    value = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = local.VPC_name
  }

}
variable "image_id" {
  type = string
  default = "ami-0583d8c7a9c35822c"
}

resource "aws_instance" "ec2" {
   ami= var.image_id
   instance_type = "t2.micro"
   security_group = aws_security_group.main.id

}