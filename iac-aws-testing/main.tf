terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "lab_instance" {
  ami             = "ami-0bb56218cdc46415d"
  instance_type   = "t4g.nano"
  tags = {
    Name = "terraform-lab-vm"
  }
}