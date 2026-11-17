output "airtable_api_key_arn" {
  description = "ARN of the AirTable API key SSM parameter"
  value       = aws_ssm_parameter.airtable_api_key.arn
}

output "google_service_account_key_arn" {
  description = "ARN of the Google Service Account key SSM parameter"
  value       = aws_ssm_parameter.google_service_account_key.arn
}

output "airtable_base_arn" {
  description = "ARN of the main Airtable base SSM parameter"
  value       = aws_ssm_parameter.airtable_base.arn
}

output "docdb_username_name" {
  description = "Name of the DocumentDB username SSM parameter"
  value       = aws_ssm_parameter.docdb_username.name
}

output "docdb_password_name" {
  description = "Name of the DocumentDB password SSM parameter"
  value       = aws_ssm_parameter.docdb_password.name
}

output "docdb_username_arn" {
  description = "ARN of the DocumentDB username SSM parameter"
  value       = aws_ssm_parameter.docdb_username.arn
}

output "docdb_password_arn" {
  description = "ARN of the DocumentDB password SSM parameter"
  value       = aws_ssm_parameter.docdb_password.arn
}
