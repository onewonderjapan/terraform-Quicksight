resource "aws_quicksight_folder" "parent" {
  folder_id = "${var.name}-app"
  name      = "app"

  lifecycle {
    ignore_changes = [
        permissions
    ] 
  }
}
resource "aws_quicksight_folder" "dev" {
  folder_id = "${var.name}-dev"
  name      = "dev"

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