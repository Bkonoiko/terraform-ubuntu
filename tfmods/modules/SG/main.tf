resource "aws_security_group" "sg1" {
  name = var.sg_name
  description = "sg for instance"
  vpc_id = var.vpc

}

resource "aws_vpc_security_group_ingress_rule" "ingress1" {
  security_group_id = aws_security_group.sg1.id
  
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ingress2" {
  security_group_id = aws_security_group.sg1.id
  
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}