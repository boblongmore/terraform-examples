provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "example" {
  ami           = "ami-acc0f0d6"
  instance_type = "t2.micro"
}
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}
output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

