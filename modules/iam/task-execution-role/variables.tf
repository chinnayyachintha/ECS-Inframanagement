variable "task_execution_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "secret_arns" {
  description = "List of Secrets Manager ARNs the task execution role can access"
  type        = list(string)
  default     = []
}

variable "parameter_arns" {
  description = "List of SSM Parameter Store ARNs the task execution role can access"
  type        = list(string)
  default     = []
}

variable "inline_policy_statements" {
  description = "Optional list of additional inline IAM policy statements"
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}
