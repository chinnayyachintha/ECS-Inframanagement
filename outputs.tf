# VPC Module Outputs
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "nat_eip_id" {
  value = module.vpc.nat_eip_id
}

output "nat_gateway_eip" {
  value = module.vpc.nat_gateway_eip
}   

# Security Groups Module Outputs
output "public_security_group_id" {
  value = module.security_groups.public_security_group_id
}

output "private_security_group_id" {
  value = module.security_groups.private_security_group_id
}
