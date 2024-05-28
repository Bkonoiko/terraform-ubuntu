resource "aws_vpc" "tf_vpc" {
  cidr_block = var.vpccider
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.sub1_cider
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = var.sub1_name
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.tf_vpc.id
  cidr_block = var.sub2_cider
  availability_zone = "us-east-1b"

  tags = {
    Name = var.sub2_name
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id

  route {
    cidr_block = var.pub_route_cidr
    gateway_id = aws_internet_gateway.tf_igw.id
  }
}


resource "aws_route_table_association" "pub_rt" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.tf_rt.id
}

resource "aws_nat_gateway" "tf_ngw" {
    subnet_id = aws_subnet.private_subnet1.id
    connectivity_type = "private"

    tags = {
      Name = var.ng_name
    }
}