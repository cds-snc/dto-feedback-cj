output "docdb_cluster_endpoint" {
  description = "The connection endpoint for the DocumentDB cluster"
  value       = aws_docdb_cluster.main.endpoint
}

output "docdb_cluster_port" {
  description = "The port for the DocumentDB cluster"
  value       = aws_docdb_cluster.main.port
}

output "docdb_security_group_id" {
  description = "The ID of the DocumentDB security group"
  value       = aws_security_group.docdb_sg.id
}