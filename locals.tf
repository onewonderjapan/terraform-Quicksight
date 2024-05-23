locals {
  service    = "onewonder"
  env        = "dev"
  system     = "backend"
  component  = "quicksight"
  region     = "ap-northeast-1"
  account_id = "485361166083"
  suffix     = ""

  customers_all = jsondecode(data.local_file.customers_data.content)["customers"]
  customers = {
    for k, customer in local.customers_all : k => customer
  }
}