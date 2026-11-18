# SSM Parameter ARNs for secrets
variable "airtable_api_key_arn" {
  description = "ARN of the AirTable API key SSM parameter"
  type        = string
}

variable "airtable_base_arn" {
  description = "ARN of the AirTable Base SSM parameter"
  type        = string
}

variable "google_service_account_key_arn" {
  description = "ARN of the Google Service Account key SSM parameter"
  type        = string
}

variable "docdb_uri_arn" {
  description = "ARN of the DocumentDB URI SSM parameter"
  type        = string
}

variable "docdb_username_arn" {
  description = "ARN of the DocumentDB username SSM parameter"
  type        = string
}

variable "docdb_password_arn" {
  description = "ARN of the DocumentDB password SSM parameter"
  type        = string
}
