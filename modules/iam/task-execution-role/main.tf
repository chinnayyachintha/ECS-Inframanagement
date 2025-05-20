resource "aws_iam_role" "ecs_task_execution" {
  name               = var.task_execution_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "ecs_task_execution_inline" {
  name   = "${var.task_execution_name}-inline-policy"
  role   = aws_iam_role.ecs_task_execution.id
  policy = data.aws_iam_policy_document.ecs_execution_policy.json
}

data "aws_iam_policy_document" "ecs_execution_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }

  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    resources = var.secret_arns
    condition {
      test     = "StringEquals"
      variable = "secretsmanager:SecretId"
      values   = var.secret_arns
    }
  }

  statement {
    actions   = ["ssm:GetParameters", "ssm:GetParameter"]
    resources = var.parameter_arns
  }

#   dynamic "statement" {
#     for_each = var.inline_policy_statements
#     content {
#       actions   = statement.value.actions
#       resources = statement.value.resources
#     }
#   }
}
