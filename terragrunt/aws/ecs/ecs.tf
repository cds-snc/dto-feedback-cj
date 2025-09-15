locals {
  container_secrets = [
    {
      "name"      = "SPRING_DATA_MONGODB_URI"
      "valueFrom" = var.mongodb_uri_arn
    },
    {
      "name"      = "AIRTABLE_KEY"
      "valueFrom" = var.airtable_api_key_arn
    },
    {
      "name"      = "GOOGLE_SERVICE_ACCOUNT_KEY"
      "valueFrom" = var.google_service_account_key_arn
    },
    {
      "name"      = "AIRTABLE_BASE"
      "valueFrom" = var.airtable_base_arn
    },
    {
      "name"      = "HEALTH_AIRTABLE_BASE"
      "valueFrom" = var.health_airtable_base_arn
    },
    {
      "name"      = "CRA_AIRTABLE_BASE"
      "valueFrom" = var.cra_airtable_base_arn
    },
    {
      "name"      = "TRAVEL_AIRTABLE_BASE"
      "valueFrom" = var.travel_airtable_base_arn
    },
    {
      "name"      = "IRCC_AIRTABLE_BASE"
      "valueFrom" = var.ircc_airtable_base_arn
    }
  ]

  container_environment = [
    {
      "name"  = "AIRTABLE_TAB"
      "value" = "Page feedback"
    },
    {
      "name"  = "AIRTABLE_PAGE_TITLE_LOOKUP"
      "value" = "Page feedback statistics"
    },
    {
      "name"  = "AIRTABLE_ML_TAGS"
      "value" = "ML Tags"
    },
    {
      "name"  = "AIRTABLE_URL_LINK"
      "value" = "Page groups by URL"
    }
  ]
}

module "feedback_cronjob" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.7.0"

  # Cluster and service - Note: This will be used as a scheduled task, not a service
  cluster_name = "${var.product_name}-cluster"
  service_name = "${var.product_name}-task-service"

  # Task/Container definition
  container_image            = "${var.ecr_repository_url}:latest"
  container_name             = var.product_name
  task_cpu                   = var.fargate_cpu
  task_memory                = var.fargate_memory
  container_secrets          = local.container_secrets
  container_environment      = local.container_environment
  container_linux_parameters = {}
  container_ulimits = [
    {
      "hardLimit" : 65536,
      "name" : "nofile",
      "softLimit" : 65536
    }
  ]
  container_read_only_root_filesystem = false

  # Task definition
  task_name          = "${var.product_name}-task"
  task_exec_role_arn = var.task_execution_role_arn
  task_role_arn      = var.task_role_arn

  # Scaling - Set to 0 since this is a scheduled task
  enable_autoscaling = false
  desired_count      = 0

  # Networking
  security_group_ids = [aws_security_group.ecs_tasks.id]
  subnet_ids         = var.vpc_private_subnet_ids

  # No load balancer needed for cronjob
  lb_target_group_arn = null

  # Forward logs to Sentinel
  sentinel_forwarder           = true
  sentinel_forwarder_layer_arn = "arn:aws:lambda:ca-central-1:283582579564:layer:aws-sentinel-connector-layer:199"

  billing_tag_value = var.billing_code

  # Enable execute command only in staging for debugging
  enable_execute_command = var.env == "staging" ? true : false
}

# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "feedback_cronjob" {
  name              = "/aws/ecs/${var.product_name}-cluster"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "feedback_cronjob" {
  name           = "${var.product_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.feedback_cronjob.name
}
