# IAM Role definitions

# Policy for ECS task role
data "aws_iam_policy_document" "feedback-cronjob-ecs-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "feedback-cronjob-ssm-policy" {
  statement {
    sid    = "AllowSSMParameterAccess"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    resources = [
      var.docdb_uri_arn,
      var.docdb_username_arn,
      var.docdb_password_arn,
      var.airtable_api_key_arn,
      var.airtable_base_arn,
      var.google_service_account_key_arn,
      var.health_airtable_base_arn,
      var.cra_airtable_base_arn,
      var.travel_airtable_base_arn,
      var.ircc_airtable_base_arn,
    ]
  }
}

resource "aws_iam_policy" "feedback-cronjob-ssm-policy" {
  name        = "${var.product_name}-ssm-policy"
  description = "Policy for ${var.product_name} ${var.env} to access SSM parameters"
  policy      = data.aws_iam_policy_document.feedback-cronjob-ssm-policy.json

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

resource "aws_iam_role" "feedback-cronjob-ecs-role" {
  name               = "${var.product_name}-ecs-role"
  assume_role_policy = data.aws_iam_policy_document.feedback-cronjob-ecs-policy.json
}

resource "aws_iam_role_policy_attachment" "feedback-cronjob-ecs-policy" {
  role       = aws_iam_role.feedback-cronjob-ecs-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy_attachment" "feedback-cronjob-ssm-policy" {
  name       = "${var.product_name}-ssm-policy"
  policy_arn = aws_iam_policy.feedback-cronjob-ssm-policy.arn
  roles      = [aws_iam_role.feedback-cronjob-ecs-role.name]
}
