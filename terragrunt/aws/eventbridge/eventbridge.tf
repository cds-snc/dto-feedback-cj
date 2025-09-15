# EventBridge Rule for 10-minute schedule
resource "aws_cloudwatch_event_rule" "feedback_cronjob_schedule" {
  name                = "${var.product_name}-schedule"
  description         = "Trigger feedback cronjob every 10 minutes"
  schedule_expression = "rate(10 minutes)"

  tags = {
    "CostCentre" = var.billing_code
  }
}

# EventBridge Target - ECS Task
resource "aws_cloudwatch_event_target" "ecs_target" {
  rule      = aws_cloudwatch_event_rule.feedback_cronjob_schedule.name
  target_id = "${var.product_name}-ecs-target"
  arn       = var.cluster_arn
  role_arn  = aws_iam_role.eventbridge_role.arn

  ecs_target {
    task_count          = 1
    task_definition_arn = var.task_definition_arn
    launch_type         = "FARGATE"
    platform_version    = "LATEST"

    network_configuration {
      subnets          = var.vpc_private_subnet_ids
      security_groups  = [var.security_group_id]
      assign_public_ip = false
    }
  }
}

# IAM Role for EventBridge to invoke ECS tasks
resource "aws_iam_role" "eventbridge_role" {
  name = "${var.product_name}-eventbridge-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    "CostCentre" = var.billing_code
  }
}

# IAM Policy for EventBridge to run ECS tasks
resource "aws_iam_role_policy" "eventbridge_policy" {
  name = "${var.product_name}-eventbridge-policy"
  role = aws_iam_role.eventbridge_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:RunTask"
        ]
        Resource = [
          var.task_definition_arn,
          "${var.cluster_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:PassRole"
        ]
        Resource = [
          var.task_execution_role_arn,
          var.task_role_arn
        ]
      }
    ]
  })
}
