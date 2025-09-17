output "ecr_repository_url" {
  description = "URL of the Feedback Cronjob ECR"
  value       = aws_ecr_repository.feedback_cronjob.repository_url
}

output "ecr_repository_arn" {
  description = "Arn of the ECR Repository"
  value       = aws_ecr_repository.feedback_cronjob.arn
}