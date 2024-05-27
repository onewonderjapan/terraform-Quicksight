module "quicksight" {
  source = "./module/quicksight_resource"

  for_each = local.customers

  account_id = local.account_id
  name       = each.key
  namespace  = "default"
  region     = each.value.region
  s3_bucket  = each.value.bucket_name
}
resource "aws_iam_policy" "quicksight_s3_policy" {
  name        = "AWSQuickSightS3Policy"
  description = "Grants Amazon QuickSight read permission to Amazon S3 resources"
  path        = "/service-role/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListAllMyBuckets",
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Action" : [
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : [
          for bucket_name in local.bucket_names : "arn:aws:s3:::${bucket_name}"
        ]
      },
      {
        "Action" : [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        "Effect" : "Allow",
        "Resource" : [
          for bucket_name in local.bucket_names : "arn:aws:s3:::${bucket_name}/*"
        ]
      }
    ]
  })
}