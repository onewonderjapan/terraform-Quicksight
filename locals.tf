locals {
  users = jsondecode(data.local_file.users.content)

  default_buckets = {
    for user in local.users : user.name => ["${lower(user.name)}-s3-bucket"]
  }

  default_policy_name = {
    for user in local.users : user.name => "${user.name}-policy"
  }

  default_quicksight_groups = {
    for user in local.users : user.name => [
      {
        "GroupName" = user.name,
        "QuickSight_user" = [
          {
            "UserName" = "${user.name}-admin",
            "Email"    = "${user.name}-admin@example.com",
            "Role"     = "ADMIN"
          }
        ]
      }
    ]
  }

  policies = {
    for user in local.users : user.name => {
      "Version" = "2012-10-17",
      "Statement" = [
        {
          "Effect" = "Allow",
          "Action" = [
            "quicksight:*",
            "s3:*"
          ],
          "Resource" = flatten([
            for bucket in local.default_buckets[user.name] : [
              "arn:aws:s3:::${bucket}",
              "arn:aws:s3:::${bucket}/*"
            ]
          ])
        },
        {
          "Effect" = "Allow",
          "Action" = [
            "quicksight:*",
            "s3:*"
          ],
          "Resource" = "*"
        }
      ]
    }
  }

  quicksight_groups = flatten([
    for user in local.users : [
      for group in local.default_quicksight_groups[user.name] : {
        group_name       = group.GroupName
        user_name        = user.name
        quicksight_users = lookup(group, "QuickSight_user", [])
      }
    ]
  ])

  quicksight_users = flatten([
    for user in local.users : [
      for group in local.default_quicksight_groups[user.name] : [
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