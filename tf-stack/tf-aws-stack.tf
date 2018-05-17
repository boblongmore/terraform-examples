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

data "subnet_id" "selected" {
  vpc_id = "${var.vpc_id}"
}

#resource "aws_lb" "test" {
#  name = "tf-example-lb"
#  load_balancer_type = "application"
#  security_groups = "web"
#  subnets = ["${elementdata.aws_subnet.selected.vpc_id}"]
#  tags {
#    Name = "tf-created"
#  }
#}
resource "aws_eip" "ip" {
  count = 3
  instance = "${element(aws_instance.tf-example-01.*.id, count.index)}"
}
#output "ip" {
#  value = ["${aws_eip.ip.*.public_ip}"]
#}