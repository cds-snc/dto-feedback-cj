output "ecs_role_arn" {
  description = "ARN of the ECS role"
  value       = aws_iam_role.feedback-cronjob-ecs-role.arn
}

output "ecs_role_name" {
  description = "Name of the ECS role"
  value       = aws_iam_role.feedback-cronjob-ecs-role.name
}
