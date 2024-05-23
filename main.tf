module "quicksight" {
  source = "./module/quicksight_resource"

  for_each = local.customers

  account_id = local.account_id
  name       = each.key
  namespace  = "default"
  region     = local.region
  s3_bucket  = "${each.value.bucket_name}${local.suffix}"
}