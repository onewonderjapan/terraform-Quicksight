resource "null_resource" "share_folder_with_group" {
  provisioner "local-exec" {
    command = <<EOT
      bash ./script/share_folder.sh ${var.account_id} ${aws_quicksight_folder.app.folder_id} arn:aws:quicksight:${var.region}:${var.account_id}:group/default/${aws_quicksight_group.group.group_name} ${var.region}
    EOT
  }
}