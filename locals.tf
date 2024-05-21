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