module "s3_buckets" {
  source      = "./terraform-modules/s3"
  for_each    = local.customers
  bucket_name = each.value.bucket_name
}

resource "aws_iam_policy" "s3_policy" {
  name = "S3TestPolicy"
  path = "/service-role/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets",
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket"
        ],
        "Resource" : [
          for bucket_name in local.bucket_names : "arn:aws:s3:::${bucket_name}"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/Customer" : "true"
          }
        }
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        "Resource" : [
          for bucket_name in local.bucket_names : "arn:aws:s3:::${bucket_name}/*"
        ],
        "Condition" : {
          "StringEquals" : {
            "aws:ResourceTag/Customer" : "true"
          }
        }
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = "S3Test"
  policy_arn = aws_iam_policy.s3_policy.arn
}