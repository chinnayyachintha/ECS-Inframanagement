# AWS Region
aws_region = "ca-central-1"

# VPC Configuration Variables
vpc_cidr_block = "10.0.0.0/16"

public_subnets = {
  "public-subnet-1" = "10.0.1.0/24"
  "public-subnet-2" = "10.0.2.0/24"
}

private_subnets = {
  "private-subnet-1" = "10.0.101.0/24"
  "private-subnet-2" = "10.0.102.0/24"
}

common_tags = {
  Name        = "PopStream-Pricing-vpc"
  Environment = "Production"
  Owner       = "Chinnayya Chintha"
  Project     = "PopStream-Pricing"
}
