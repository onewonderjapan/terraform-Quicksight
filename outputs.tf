output "quicksight_role_arn" {
  value = aws_iam_role.quicksight_role.arn
}

output "quicksight_group_name" {
  value = aws_quicksight_group.a_company_group.group_name
}

output "quicksight_dashboard_id" {
  value = aws_quicksight_dashboard.a_company_dashboard.dashboard_id
}
