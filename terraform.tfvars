# AWS Region
aws_region = "ca-central-1"

# VPC Module Configuration Variables
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

# Security Groups Module Configuration Variables
public_sg_name  = "Public-SG"
private_sg_name = "Private-SG"

# ECS Cluster Module Configuration Variables
cluster_name = "my-app-cluster"