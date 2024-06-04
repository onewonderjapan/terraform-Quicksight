module "s3_buckets" {
  source      = "./terraform-modules/s3"
  for_each    = local.customers
  bucket_name = each.value.bucket_name
}

resource "aws_iam_policy" "s3_policy" {
  count = length(local.customers_groups)
  
  name = "S3TestPolicy-${count.index + 1}"
  path = "/service-role/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ListAllBuckets",
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets",
        "Resource" : "*"
      },
      {
        "Sid" : "ListSpecificBuckets",
        "Effect" : "Allow",
        "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
        ],
        "Resource": [for bucket_name in local.customers_groups[count.index] : "arn:aws:s3:::${bucket_name}"]
      },
      {
        "Sid" : "GetObjectFromSpecificBuckets",
        "Effect" : "Allow",
        "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
        ],
        "Resource": [for bucket_name in local.customers_groups[count.index] : "arn:aws:s3:::${bucket_name}/*"]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  count = length(local.customers_groups)
  user       = "S3Test"
  policy_arn = aws_iam_policy.s3_policy[count.index].arn
}