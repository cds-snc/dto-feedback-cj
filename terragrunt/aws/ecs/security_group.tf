###
# Security group for ECS Fargate scheduled task
###

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.product_name}-ecs-sg"
  description = "Security group for feedback cronjob ECS tasks"
  vpc_id      = var.vpc_id

  tags = {
    "CostCentre" = var.billing_code
  }
}

# Allow all outbound traffic for API calls (MongoDB, AirTable, Google Sheets, ML service)
resource "aws_security_group_rule" "ecs_egress_all" {
  description       = "Allow ECS tasks to make outbound API calls"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_tasks.id
}

###
# Traffic to DocumentDB should only come from ECS
###

resource "aws_security_group_rule" "database_ingress_ecs" {
  description              = "Allow DocumentDB cluster to receive requests from ECS"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ecs_tasks.id
  security_group_id        = var.aws_docdb_security_group_id
}

resource "aws_security_group_rule" "database_ingress_feedback_viewer" {
  count                    = var.feedback_viewer_security_group_id != "" ? 1 : 0
  description              = "Allow DocumentDB cluster to receive requests from feedback-viewer ECS"
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = var.feedback_viewer_security_group_id
  security_group_id        = var.aws_docdb_security_group_id
}