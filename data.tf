data "local_file" "users" {
  filename = "users.json"
}

data "aws_caller_identity" "current" {}