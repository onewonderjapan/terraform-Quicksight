resource "aws_quicksight_folder" "parent" {
  folder_id = "${var.name}-id"
  name      = var.name

  lifecycle {
    ignore_changes = [
        permissions
    ] 
  }
}

resource "aws_quicksight_folder" "app" {
  folder_id = "${var.name}-app-id"
  name      = "${var.name}-app"

  parent_folder_arn = aws_quicksight_folder.parent.arn
}

resource "aws_quicksight_folder" "store" {
  folder_id = "${var.name}-store-id"
  name      = "${var.name}-store"

  parent_folder_arn = aws_quicksight_folder.parent.arn
}