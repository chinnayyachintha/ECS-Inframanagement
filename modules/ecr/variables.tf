variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Whether image tags can be overwritten"
  type        = string
  default     = "IMMUTABLE"
}

variable "encryption_type" {
  description = "Encryption type: AES256 or KMS"
  type        = string
  default     = "AES256"
}

variable "kms_key" {
  description = "KMS key ARN if encryption_type is KMS"
  type        = string
  default     = null
}

variable "enable_lifecycle_policy" {
  description = "Whether to enable lifecycle policy"
  type        = bool
  default     = false
}

variable "attach_repository_policy" {
  description = "Whether to attach a repository policy"
  type        = bool
  default     = false
}

variable "repository_policy_iam_role_arn" {
  description = "IAM role ARN to allow push/pull access"
  type        = string
  default     = null
}

variable "enable_image_scan" {
  description = "Enable image scan on push to ECR repository"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}
