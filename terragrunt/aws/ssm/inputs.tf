variable "docdb_uri" {
  description = "DocumentDB connection URI"
  type        = string
  sensitive   = true
}

variable "airtable_api_key" {
  description = "AirTable API key"
  type        = string
  sensitive   = true
}

variable "google_service_account_key" {
  description = "Google Service Account key (JSON)"
  type        = string
  sensitive   = true
}

variable "airtable_base" {
  description = "Main Airtable base ID"
  type        = string
  sensitive   = true
}

variable "health_airtable_base" {
  description = "Health Airtable base ID"
  type        = string
  sensitive   = true
}

variable "cra_airtable_base" {
  description = "CRA Airtable base ID"
  type        = string
  sensitive   = true
}

variable "travel_airtable_base" {
  description = "Travel Airtable base ID"
  type        = string
  sensitive   = true
}

variable "ircc_airtable_base" {
  description = "IRCC Airtable base ID"
  type        = string
  sensitive   = true
}

variable "docdb_username" {
  description = "DocumentDB master username"
  type        = string
  sensitive   = true
}

variable "docdb_password" {
  description = "DocumentDB master password"
  type        = string
  sensitive   = true
}
