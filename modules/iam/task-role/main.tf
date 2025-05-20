resource "aws_iam_role" "ecs_task" {
  name               = var.task_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# resource "aws_iam_role_policy" "inline" {
#   count  = length(var.inline_policy_statements) > 0 ? 1 : 0
#   name   = "${var.task_name}-custom-inline"
#   role   = aws_iam_role.ecs_task.id
#   policy = data.aws_iam_policy_document.custom.json
# }

# data "aws_iam_policy_document" "custom" {
#   dynamic "statement" {
#     for_each = var.inline_policy_statements
#     content {
#       actions   = statement.value.actions
#       resources = statement.value.resources
#     }
#   }
# }

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.managed_policy_arns)

  role       = aws_iam_role.ecs_task.name
  policy_arn = each.value
}
