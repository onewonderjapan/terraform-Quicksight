data "aws_s3_bucket" "s3" {
  bucket = var.s3_bucket
}

data "template_file" "manifest" {
  template = file("./manifest/manifest_template.json")
  vars = {
    bucket_name = data.aws_s3_bucket.s3.bucket
    region      = "ap-northeast-1"
  }
}

resource "aws_s3_bucket_object" "manifest" {
  bucket = data.aws_s3_bucket.s3.bucket
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