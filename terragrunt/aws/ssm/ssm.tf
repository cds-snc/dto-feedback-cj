# SSM Parameters for feedback cronjob secrets
resource "aws_ssm_parameter" "mongodb_uri" {
  name        = "/${var.product_name}/${var.env}/mongodb-uri"
  description = "MongoDB connection URI for feedback cronjob"
  type        = "SecureString"
  value       = var.mongodb_uri

  tags = {
    Name        = "${var.product_name}-mongodb-uri"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "airtable_api_key" {
  name        = "/${var.product_name}/${var.env}/airtable-api-key"
  description = "AirTable API key for feedback cronjob"
  type        = "SecureString"
  value       = var.airtable_api_key

  tags = {
    Name        = "${var.product_name}-airtable-api-key"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "google_service_account_key" {
  name        = "/${var.product_name}/${var.env}/google-service-account-key"
  description = "Google Service Account key for Google Sheets API"
  type        = "SecureString"
  value       = var.google_service_account_key

  tags = {
    Name        = "${var.product_name}-google-service-account-key"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "airtable_base" {
  name        = "/${var.product_name}/${var.env}/airtable-base"
  description = "Main Airtable base ID"
  type        = "SecureString"
  value       = var.airtable_base

  tags = {
    Name        = "${var.product_name}-airtable-base"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "health_airtable_base" {
  name        = "/${var.product_name}/${var.env}/health-airtable-base"
  description = "Health Airtable base ID"
  type        = "SecureString"
  value       = var.health_airtable_base

  tags = {
    Name        = "${var.product_name}-health-airtable-base"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "cra_airtable_base" {
  name        = "/${var.product_name}/${var.env}/cra-airtable-base"
  description = "CRA Airtable base ID"
  type        = "SecureString"
  value       = var.cra_airtable_base

  tags = {
    Name        = "${var.product_name}-cra-airtable-base"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "travel_airtable_base" {
  name        = "/${var.product_name}/${var.env}/travel-airtable-base"
  description = "Travel Airtable base ID"
  type        = "SecureString"
  value       = var.travel_airtable_base

  tags = {
    Name        = "${var.product_name}-travel-airtable-base"
    Environment = var.env
    Product     = var.product_name
  }
}

resource "aws_ssm_parameter" "ircc_airtable_base" {
  name        = "/${var.product_name}/${var.env}/ircc-airtable-base"
  description = "IRCC Airtable base ID"
  type        = "SecureString"
  value       = var.ircc_airtable_base

  tags = {
    Name        = "${var.product_name}-ircc-airtable-base"
    Environment = var.env
    Product     = var.product_name
  }
}
