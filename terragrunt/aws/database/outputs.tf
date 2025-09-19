output "aws_docdb_cluster_id" {
  description = "The document db cluster id"
  value       = aws_docdb_cluster.feedback_cronjob_docdb_cluster.id
}

output "aws_docdb_cluster_arn" {
  description = "The document db cluster arn"
  value       = aws_docdb_cluster.feedback_cronjob_docdb_cluster.arn
}

output "aws_docdb_cluster_endpoint" {
  description = "The document db cluster endpoint"
  value       = aws_docdb_cluster.feedback_cronjob_docdb_cluster.endpoint
}

output "aws_docdb_security_group_id" {
  description = "The security group id of the document db database"
  value       = aws_security_group.feedback_cronjob_docdb_sg.id
}

output "docdb_uri_arn" {
  description = "ARN of the Document DB URI parameter"
  value       = aws_ssm_parameter.docdb_uri.arn
}

output "docdb_uri_name" {
  description = "Name of the Document DB URI parameter"
  value       = aws_ssm_parameter.docdb_uri.name
}
