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

resource "aws_network_acl_rule" "ecs_egress_mongodb_port" {
  network_acl_id = "acl-0d283394117fa789e" # feedback-cronjob_main_nacl
  rule_number    = 100 # A rule number lower than the implicit deny rule
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 10255
  to_port        = 10255
  depends_on = [
    aws_security_group.ecs_tasks
  ]
}