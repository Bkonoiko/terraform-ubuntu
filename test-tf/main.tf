//data for vpc
data "aws_vpc" "def_vpc" {
  default = true
}

data "aws_subnet" "def_subnet1a" {
  id = "subnet-0e0493e03ce0991e9"
}

data "aws_subnet" "def_subnet1b" {
  id = "subnet-0eb9e95dd868eca2c"
}

//sg
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "sg for alb and webservers"
  vpc_id      = data.aws_vpc.def_vpc.id

  ingress {
    description = "inboud rules for ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "inboud rules for https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "inboud rules for ssh"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

//alb config
resource "aws_alb" "alb1" {
  internal           = false
  load_balancer_type = "application"
  name               = "atlasalb"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [data.aws_subnet.def_subnet1a.id, data.aws_subnet.def_subnet1b.id]
  depends_on         = [aws_security_group.lb_sg]
}

//target group
resource "aws_alb_target_group" "tg1" {
  load_balancing_algorithm_type = "round_robin"
  name                          = "tg1"
  port                          = 80
  protocol                      = "HTTP"
  slow_start                    = 120
  target_type                   = "instance"
  vpc_id                        = data.aws_vpc.def_vpc.id

  depends_on = [aws_alb.alb1]
}

//lb listener
resource "aws_alb_listener" "listener1" {
  load_balancer_arn = aws_alb.alb1.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg1.arn
  }
  port       = 80
  protocol   = "HTTP"
  depends_on = [aws_alb.alb1, aws_alb_target_group.tg1]
}

//launch template
resource "aws_launch_template" "lt1" {
  image_id               = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  name                   = "myfirstlt"
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  depends_on             = [aws_security_group.lb_sg]
  user_data = base64encode(
    <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install apache2* -y
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "Hi i am $HOSTNAME" >> /var/www/html/index.html    
    EOF
  )
}

//asg config
resource "aws_autoscaling_group" "asg1" {
  name             = "ASG1"
  max_size         = 5
  min_size         = 1
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.lt1.id
    version = aws_launch_template.lt1.latest_version
  }
  health_check_type   = "ELB"
  vpc_zone_identifier = [ data.aws_subnet.def_subnet1a.id, data.aws_subnet.def_subnet1b.id ]
  target_group_arns   = [aws_alb_target_group.tg1.arn]
  depends_on          = [aws_launch_template.lt1, aws_alb_target_group.tg1]


}
