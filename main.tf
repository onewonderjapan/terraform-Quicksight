provider "aws" {
  region = "ap-northeast-1"
}

data "local_file" "users" {
  filename = "users.json"
}

data "aws_caller_identity" "current" {}

locals {
  users = jsondecode(data.local_file.users.content)

  policies = {
    for user in local.users : user.name => {
      "Version" = "2012-10-17",
      "Statement" = [
        {
          "Effect" = "Allow",
          "Action" = [
            "s3:*"
          ],
          "Resource" = flatten([
            for bucket in user.buckets : [
              "arn:aws:s3:::${bucket}",
              "arn:aws:s3:::${bucket}/*"
            ]
          ])
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "quicksight:CreateUser",
            "quicksight:CreateGroup",
            "quicksight:DescribeGroup",
            "quicksight:ListGroupMemberships",
            "quicksight:ListGroups"
          ],
          "Resource" = "*"
        }
      ]
    }
  }

  quicksight_groups = flatten([
    for user in local.users : [
      for group in user.QuickSight_groups : {
        group_name       = group.GroupName
        user_name        = user.name
        quicksight_users = lookup(group, "QuickSight_user", [])
      }
    ]
  ])

  quicksight_users = flatten([
    for user in local.users : [
      for group in user.QuickSight_groups : [
        for qs_user in lookup(group, "QuickSight_user", []) : {
          user_name  = qs_user.UserName
          email      = qs_user.Email
          role       = qs_user.Role
          group_name = group.GroupName
        }
      ]
    ]
  ])
}

resource "aws_iam_user" "user" {
  for_each = { for user in local.users : user.name => user }

  name          = each.value.name
  force_destroy = true
}

resource "aws_iam_policy" "policy" {
  for_each = local.policies

  name   = each.key
  policy = jsonencode(each.value)
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  for_each = local.policies

  user       = aws_iam_user.user[each.key].name
  policy_arn = aws_iam_policy.policy[each.key].arn
}

resource "aws_quicksight_group" "quicksight_group" {
  for_each = { for group in local.quicksight_groups : "${group.user_name}-${group.group_name}" => group }

  aws_account_id = data.aws_caller_identity.current.account_id
  group_name     = each.value.group_name
  namespace      = "default"
}

resource "aws_quicksight_user" "quicksight_user" {
  for_each = { for qs_user in local.quicksight_users : qs_user.user_name => qs_user }

  aws_account_id = data.aws_caller_identity.current.account_id
  email          = each.value.email
  identity_type  = "QUICKSIGHT" # 変更
  user_role      = each.value.role
  namespace      = "default"
  user_name      = each.value.user_name
  depends_on     = [aws_quicksight_group.quicksight_group]
}

resource "aws_quicksight_group_membership" "quicksight_group_membership" {
  for_each = { for qs_user in local.quicksight_users : "${qs_user.user_name}-${qs_user.group_name}" => qs_user }

  aws_account_id = data.aws_caller_identity.current.account_id
  group_name     = each.value.group_name
  namespace      = "default"
  member_name    = each.value.user_name
  depends_on     = [aws_quicksight_user.quicksight_user]
}
