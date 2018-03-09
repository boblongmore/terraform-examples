provider "aws" {
  region     = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bob-vpc"
  cidr = "10.10.0.0/16"

  
}