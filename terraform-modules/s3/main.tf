resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = {
    Customer  = true
  }
}
#resource "aws_s3_bucket_policy" "example_policy" {
 # bucket = var.bucket_name
#
#  policy = jsonencode({
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Sid": "AllowListBucketForSpecificUser",
#            "Effect": "Allow",
#            "Principal": {
#                "AWS": "arn:aws:iam::566601428909:user/S3Test"
#            },
#            "Action": "s3:ListBucket",
#            "Resource": "arn:aws:s3:::${aws_s3_bucket.this.bucket}"
#       }
#    ]
#})
#}
