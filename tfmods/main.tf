module "iam" {
  source = "./modules/iam"

  group_name = "group1"
}

module "ec2" {
  source = "./modules/ec2"

  instance_name = module.iam.username
  depends_on = [ module.iam ]
}