resource "aws_quicksight_group" "group" {
  aws_account_id = var.account_id
  group_name     = var.name
  namespace      = var.namespace
}