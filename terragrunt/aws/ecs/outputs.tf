output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.feedback_cronjob.arn
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.feedback_cronjob.task_definition_arn
}

output "ecs_tasks_security_group_id" {
  description = "ID of the ECS tasks security group"
  value       = aws_security_group.ecs_tasks.id
}