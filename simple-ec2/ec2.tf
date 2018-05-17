provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "tf-example-01" {
  count = 3
  ami           = "ami-49ac3a36"
  instance_type = "t2.micro"
  key_name = "web"
  security_groups = ["web"]
  tags {
    Name = "tf-created"
  }
 provisioner "local-exec" {
   command = "sleep 120; /etc/ansible/hosts; ansible-playbook site.yml"
 }
}
#resource "aws_eip" "ip" {
#  instance = "${aws_instance.tf-example-01.*.id}"
#}
#output "ip" {
#  value = "${(aws_eip.ip.public_ip}"
#}