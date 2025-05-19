variable "vpc_id" {
  description = "VPC ID where security groups are created"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "public_sg_name" {
  description = "Name for the public security group"
  type        = string
}

variable "private_sg_name" {
  description = "Name for the private security group"
  type        = string
}
