resource "aws_instance" "my_instance" {
  availability_zone = "us-east-1a"
  ami               = "ami-04b70fa74e45c3917"
  instance_type     = "t2.micro"
  tags = {
    "Name" = "test_ec2"
  }



}