resource "aws_ecr_repository" "this" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.enable_image_scan
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" ? var.kms_key : null
  }

  tags = var.common_tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = var.enable_lifecycle_policy ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = file("${path.module}/lifecycle_policy.json")
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "AllowPushPull"
    effect = "Allow"

    principals {
      type = "AWS"

      # Conditionally include the IAM role ARN if it is not null
      identifiers = var.repository_policy_iam_role_arn != null ? [var.repository_policy_iam_role_arn] : []
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
  }

  # Add any additional statements here if needed
}

resource "aws_ecr_repository_policy" "this" {
  count      = var.attach_repository_policy ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = data.aws_iam_policy_document.this.json
}
