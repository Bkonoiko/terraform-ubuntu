module "vpc" {
    source = "./modules/vpc"
}

module "ec2" {
  
}

module "route53" {
  
}

module "alb" {
    source = "./modules/alb"
    vpc_id = module.vpc.vpc_id
    snid1 = module.vpc.snid1
    snid2 = module.vpc.snid2
    sgid = module.sg.sgid
    depends_on = [ module.vpc ]
}

module "lt" {
  source = "./modules/lt"
  sgid = module.sg.sgid
  depends_on = [ module.alb ]
}

module "asg1" {
  source = "./modules/asg"
  ltid = module.lt.ltid
  ltversion = module.lt.ltversion
  depends_on = [ module.lt ]
}

