# SSM Parameter ARNs for secrets
variable "mongodb_uri_arn" {
  description = "ARN of the MongoDB URI SSM parameter"
  type        = string
}

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

variable "health_airtable_base_arn" {
  description = "ARN of the Health AirTable Base SSM parameter"
  type        = string
}

variable "cra_airtable_base_arn" {
  description = "ARN of the CRA AirTable Base SSM parameter"
  type        = string
}

variable "travel_airtable_base_arn" {
  description = "ARN of the Travel AirTable Base SSM parameter"
  type        = string
}

variable "ircc_airtable_base_arn" {
  description = "ARN of the IRCC AirTable Base SSM parameter"
  type        = string
}
