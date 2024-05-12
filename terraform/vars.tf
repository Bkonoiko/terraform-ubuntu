variable "bucketname" {
  description = "name of s3 bucket"
  type = string
  default = "tfuser-bucket"
}

variable "version_status" {
    description = "version of bucket"
    type = string
    default = "Enabled"
  
}

variable "vpccider" {
  description = "cidr for vpc"
  type = string
  default = "192.168.0.0/16"
}

variable "sub1_cider" {
  description = "cidr for subnet 1"
  type = string
  default = "192.168.1.0/24"
}

variable "vpc_name" {
  description = "name for vpc"
  type = string
  default = "tf_vpc"
}

variable "sub2_cider" {
  description = "cidr for subnet 2"
  type = string
  default = "192.168.2.0/24"
}

variable "sub2_name" {
  description = "name for subnet 2"
  type = string
  default = "td_subnet2"
}

variable "sub1_name" {
  description = "name for subnet 1"
  type = string
  default = "td_subnet1"
}

variable "igw_name" {
  description = "name for vpc igw"
  type = string
  default = "tf_vpc_igw"
}

variable "pub_route_cidr" {
  description = "cidr for route public"
  type = string
  default = "0.0.0.0/0"
}

variable "ng_name" {
  description = "name for nat gatwaye"
  type = string
  default = "tf_ngw"
}