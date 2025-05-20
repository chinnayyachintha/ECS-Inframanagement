data "aws_caller_identity" "current" {}

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
  depends_on = [
    module.vpc
  ]
}

module "ecs_task_execution_role" {
  source = "./modules/iam/task-execution-role"

  task_execution_name           = "my-ecs-execution-role"
  secret_arns                   = ["arn:aws:secretsmanager:region:${data.aws_caller_identity.current.account_id}:secret:my-secret"]
  parameter_arns                = ["arn:aws:ssm:region:${data.aws_caller_identity.current.account_id}:parameter/my-param"]

  # inline_policy_statements      = [
  #   {
  #     actions   = ["s3:GetObject"],
  #     resources = ["arn:aws:s3:::my-bucket/*"]
  #   }
  # ]
}

module "ecs_task_role" {
  source = "./modules/iam/task-role"

  task_name = "my-ecs-task-role"

  # inline_policy_statements = [
  #   {
  #     actions   = ["s3:GetObject", "s3:PutObject"],
  #     resources = ["arn:aws:s3:::my-app-data/*"]
  #   },
  #   {
  #     actions   = ["dynamodb:GetItem", "dynamodb:PutItem"],
  #     resources = ["arn:aws:dynamodb:region:${data.aws_caller_identity.current.account_id}:table/my-table"]
  #   }
  # ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}
