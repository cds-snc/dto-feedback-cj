# SSM Parameter ARNs for secrets
variable "mongodb_uri_arn" {
  description = "ARN of the MongoDB URI SSM parameter"
  type        = string
}

variable "airtable_api_key_arn" {
  description = "ARN of the AirTable API key SSM parameter"
  type        = string
}

variable "google_service_account_key_arn" {
  description = "ARN of the Google Service Account key SSM parameter"
  type        = string
}
