provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "tf-example-01" {
  count = 3
  ami           = "${var.amis}"
  instance_type = "t2.micro"
  key_name = "web"
  security_groups = ["web"]
  tags {
    Name = "tf-created"
  }
}
resource "aws_eip" "ip" {
  count = 3
  instance = "${element(aws_instance.tf-example-01.*.id, count.index)}"
}
output "ip" {
  value = ["${aws_eip.ip.*.public_ip}"]
}