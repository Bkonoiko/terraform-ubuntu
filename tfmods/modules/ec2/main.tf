resource "aws_instance" "instance1" {
  ami = var.ami
  instance_type = var.itype
  availability_zone = var.az
  key_name = var.key
  tags = {
    "Name" = var.instance_name
  }
}