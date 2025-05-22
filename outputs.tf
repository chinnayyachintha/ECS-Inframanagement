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

# ECS Task Execution Role Outputs
output "ecs_task_execution_role_name" {
  value = module.ecs_task_execution_role.role_name
}

output "ecs_task_execution_role_arn" {
  value = module.ecs_task_execution_role.role_arn
}

# ECS Task Role Outputs
output "ecs_task_role_name" {
  value = module.ecs_task_role.role_name
}

output "ecs_task_role_arn" {
  value = module.ecs_task_role.role_arn
}

# ECR Module Outputs
output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "ecr_repository_arn" {
  value = module.ecr.ecr_repository_arn
}

output "ecs_cluster_arn" {
  description = "The ARN of the ECS cluster"
  value       = module.ecs_cluster.ecs_cluster_arn
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs_cluster.ecs_cluster_name
}