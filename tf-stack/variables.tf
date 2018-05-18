variable "region" {
    default = "us-east-1"
}
variable "amis" {
    default = "ami-49ac3a36"
}
variable "vpc_id" {
    default = "vpc-75f4cb0d"
}

variable "instancecount" {
    default = 3
}

#variable "subnet_id" {}