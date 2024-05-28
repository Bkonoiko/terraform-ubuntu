//vpc
resource "aws_vpc" "vpc-53" {
  cidr_block = "192.168.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-53"
  }
}

//2 public subnets
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.vpc-53.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc-53.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet2"
  }
}

//interet gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc-53.id

  tags = {
    Name = "igw1"
  }
}

//route table
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc-53.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "rt1"
  }
}

//subnet routing
resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt1.id
}

//security group
resource "aws_security_group" "sg1" {
  name = "sg1"
  description = "rules for http/ssh"
  vpc_id = aws_vpc.vpc-53.id

  ingress {
    to_port = 22
    from_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    description = "ssh"
  }

  ingress {
    to_port = 80
    from_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    description = "http"
  }

  ingress {
    to_port = 443
    from_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    description = "https"
  }

  egress {
    to_port = 0
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = -1   
  }
}

//route53 hosted private zone
resource "aws_route53_zone" "privatezone" {
  name = "atlas.local"
  force_destroy = true

  vpc {
    vpc_id = aws_vpc.vpc-53.id
  }
  depends_on = [ aws_vpc.vpc-53 ]
}

//ec2 instance
resource "aws_instance" "vm1" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.sg1.id ]
  subnet_id = aws_subnet.subnet1.id
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

  depends_on = [ aws_security_group.sg1 ]

  tags = {
    Name = "vm1"
  }
}

//route 53 record
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.privatezone.id
  name = "atlas.local"
  type = "A"
  records = [ aws_instance.vm1.private_ip]
  ttl = 300

  depends_on = [ aws_instance.vm1 ]
}


