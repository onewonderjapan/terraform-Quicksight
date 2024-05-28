resource "aws_quicksight_folder" "app" {
  folder_id        = "${var.name}-app-id"
  name             = "${var.name}-app"
  parent_folder_arn = var.parent_folder_arn

  lifecycle {
    ignore_changes = [
        permissions
    ] 
  }
}