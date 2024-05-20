provider "aws" {
  region = "us-west-2"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID to be used across the resources."
}

variable "quicksight_users_file" {
  type        = string
  default     = "quicksight_users.json"
  description = "Path to the JSON file containing QuickSight users information."
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["quicksight.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "quicksight_role" {
  name               = "ACompanyQuickSightRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy" "quicksight_policy" {
  name = "ACompanyQuickSightPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:*", "athena:*", "quicksight:*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "quicksight_role_policy_attachment" {
  role       = aws_iam_role.quicksight_role.name
  policy_arn = aws_iam_policy.quicksight_policy.arn
}

# QuickSight グループを作成します。
resource "aws_quicksight_group" "a_company_group" {
  group_name     = "ACompanyGroup"
  aws_account_id = var.aws_account_id
  namespace      = "default"
}

data "local_file" "quicksight_users" {
  filename = var.quicksight_users_file
}

locals {
  quicksight_users = jsondecode(data.local_file.quicksight_users.content)
}

resource "aws_quicksight_user" "quicksight_users" {
  for_each       = { for user in local.quicksight_users.users : user.user_name => user }
  user_name      = each.value.user_name
  email          = each.value.email
  aws_account_id = var.aws_account_id
  namespace      = "default"
  identity_type  = "IAM"
  user_role      = each.value.role
  iam_arn        = aws_iam_role.quicksight_role.arn
}

resource "aws_quicksight_group_membership" "group_membership" {
  for_each       = { for user in local.quicksight_users.users : user.user_name => user }
  aws_account_id = var.aws_account_id
  namespace      = "default"
  group_name     = local.quicksight_users.group_name
  member_name    = each.value.user_name
}

