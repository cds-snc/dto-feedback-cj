# VPC module for feedback cronjob
module "feedback_cronjob_vpc" {
  source            = "github.com/cds-snc/terraform-modules//vpc?ref=v10.7.0"
  name              = var.product_name
  billing_tag_value = var.billing_tag_value

  # Enable 2 availability zones for high availability
  availability_zones = 2

  # Enable VPC flow logs and block unnecessary traffic
  enable_flow_log = true
  block_ssh       = true
  block_rdp       = true

  # Use single NAT gateway for cost optimization in non-production
  single_nat_gateway = var.env != "production"

  # Allow HTTPS outbound connections for API calls (DocumentDB, AirTable, Google Sheets, ML service)
  allow_https_request_out          = true
  allow_https_request_out_response = true

  # Cronjob doesn't need inbound HTTPS traffic
  allow_https_request_in          = false
  allow_https_request_in_response = false
}