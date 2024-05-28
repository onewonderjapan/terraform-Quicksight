resource "aws_s3_bucket" "customer_buckets" {

  bucket = var.s3_bucket
}

data "template_file" "manifest" {
  template = file("./manifest/manifest.json")
  vars = {
    bucket_name = var.s3_bucket
    region      = var.region
  }
}

resource "aws_s3_bucket_object" "manifest" {
  bucket = aws_s3_bucket.customer_buckets.bucket
  key    = "quicksight/manifest.json"
  content = data.template_file.manifest.rendered
}

resource "aws_quicksight_data_source" "s3" {
  data_source_id = "${var.name}-id"
  name           = "data in S3"

  parameters {
    s3 {
      manifest_file_location {
        bucket = var.s3_bucket
        key    = "quicksight/manifest.json"
      }
    }
  }
  type = "S3"
}
