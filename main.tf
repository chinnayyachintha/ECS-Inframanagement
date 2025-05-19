module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  common_tags    = var.common_tags
}

module "security_groups" {
  source            = "./modules/security_groups"
  
  vpc_id            = module.vpc.vpc_id
  public_sg_name    = var.public_sg_name
  private_sg_name   = var.private_sg_name
  common_tags       = var.common_tags
}
