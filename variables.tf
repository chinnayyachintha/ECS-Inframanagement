variable "aws_region" {
    description = "AWS region"
    type        = string
}

# VPC Module Variables
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  type = map(string)
}

variable "private_subnets" {
  type = map(string)
}

variable "common_tags" {
  description = "Common tags for all VPC resources"
  type        = map(string)
}

# Security Groups Module Variables
variable "public_sg_name" {
  description = "Name for the public security group"
  type        = string
}

variable "private_sg_name" {
  description = "Name for the private security group"
  type        = string
}