provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "tf-example-01" {
  count = "${var.instancecount}"
  ami           = "${var.amis}"
  instance_type = "t2.micro"
  key_name = "web"
  security_groups = ["web"]
  tags {
    Name = "tf-created"
  }
}
data "aws_subnet_ids" "selected" {
  vpc_id = "${var.vpc_id}"
}

data "aws_subnet" "selected" {
  count = "${length(data.aws_subnet_ids.selected.ids)}"
  id = "${data.aws_subnet_ids.selected.ids[count.index]}"
}

resource "aws_security_group" "web_lb" {
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "tf-created"
  }
}

resource "aws_lb_target_group" "tf-stack-tg" {
  name = "tf-stack-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = "${var.vpc_id}"
}

resource "aws_lb_target_group_attachment" "tf-stack-tg-members" {
  count = "${var.instancecount}"
  target_group_arn = "${aws_lb_target_group.tf-stack-tg.arn}"
  target_id = "${element(aws_instance.tf-example-01.*.id, count.index)}"
  port = 80
}

resource "aws_alb_listener" "tf-stack-alb-listener" {
  load_balancer_arn = "${aws_lb.tf-stack-alb.arn}"
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = "${aws_lb_target_group.tf-stack-tg.arn}"
    type = "forward"
  }
}

resource "aws_lb" "tf-stack-alb" {
  name = "tf-stack-lb"
  load_balancer_type = "application"
  enable_cross_zone_load_balancing = true
  security_groups = ["${aws_security_group.web_lb.id}"]
  subnets = ["${data.aws_subnet.selected.*.id}"]
  tags {
    Name = "tf-created"
  }
}

resource "aws_eip" "ip" {
  count = "${var.instancecount}"
  instance = "${element(aws_instance.tf-example-01.*.id, count.index)}"
}
#output "ip" {
#  value = ["${aws_eip.ip.*.public_ip}"]
#}

output "subnet_cidr_blocks" {
  value = ["${data.aws_subnet.selected.*.cidr_block}"]
}