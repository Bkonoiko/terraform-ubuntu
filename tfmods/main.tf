# module "iam" {
#   source = "./modules/iam"

#   group_name = "group1"
# }

# module "ec2" {
#   source = "./modules/ec2"

#   instance_name = module.iam.username
#   depends_on = [ module.iam ]
# }

module "myec2" {
  source        = "./modules/ec2"
  ami           = "ami-04b70fa74e45c3917"
  itype         = "t2.micro"
  az            = "us-east-1"
  instance_name = "webapp1"
  key           = "test-script"
  depends_on    = [module.sg]
}

module "sg" {
  source  = "./modules/SG"
  sg_name = "sg1"
  vpc     = "vpc-0a28d8dc5892b45a7"
}

module "backend" {
  source     = "./modules/backend"
  bucketname = "table1"
  ver_stat   = "Enabled"
  dyn_table  = "atlas_bucket"
}
