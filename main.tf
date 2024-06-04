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
        "Sid" : "ListAllBuckets",
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets"
        "Resource" : "*"
      },
      {
        "Sid" : "ListSpecificBuckets",
        "Effect" : "Allow",
        "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
        ],
       "Resource": "arn:aws:s3:::mys3bucket*"
      },
      {
        "Sid" : "GetObjectFromSpecificBuckets",
        "Effect" : "Allow",
        "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
        ],
       "Resource": "arn:aws:s3:::mys3bucket*/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = "S3Test"
  policy_arn = aws_iam_policy.s3_policy.arn
}