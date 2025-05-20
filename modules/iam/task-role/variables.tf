variable "task_name" {
  description = "IAM role name for ECS Task Role"
  type        = string
}

variable "inline_policy_statements" {
  description = "List of custom inline policy statements"
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

variable "managed_policy_arns" {
  description = "List of AWS managed policy ARNs to attach"
  type        = list(string)
  default     = []
}
