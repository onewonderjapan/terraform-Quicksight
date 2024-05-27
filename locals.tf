locals {
  service    = "onewonder"
  env        = "dev"
  system     = "backend"
  component  = "quicksight"
  account_id = "566601428909"
  suffix     = ""

  customers_all = jsondecode(data.local_file.customers_data.content)["customers"]
  customers = {
    for k, customer in local.customers_all : k => customer
  }
  bucket_names = [for customer in local.customers_all : customer.bucket_name]
}