variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)
  default     = {}
}
