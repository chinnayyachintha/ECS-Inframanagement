module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr_block = var.vpc_cidr_block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  common_tags    = var.common_tags
}