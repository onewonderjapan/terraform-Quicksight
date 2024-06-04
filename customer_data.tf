data "local_file" "customers_data" {
  filename = "customer.json"
}

locals {
  customers_all = jsondecode(data.local_file.customers_data.content)["customers"]
  customers = {
    for k, customer in local.customers_all : k => customer
  }
  bucket_names = [for customer in local.customers_all : customer.bucket_name]
  customers_groups = [
    for i in range(0, length(local.bucket_names), 10) :
    slice(local.bucket_names, i, min(i + 10, length(local.bucket_names)))
  ]
}
