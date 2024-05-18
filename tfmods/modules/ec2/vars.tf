variable "ami" {
    type = string
    description = "ami"
    default = "ami-04b70fa74e45c3917"
}

variable "itype" {
    type = string
    description = "instance type"
    default = "t2.micro"
}

variable "az" {
    type = string
    description = "az"
    default = "us-east-1a"
}

variable "instance_name" {
    type = string
    description = "instance name"
}