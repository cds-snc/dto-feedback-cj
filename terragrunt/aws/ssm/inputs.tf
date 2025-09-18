variable "docdb_master_username" {
  description = "The master username for the DocumentDB cluster"
  type        = string
}

variable "docdb_master_password" {
  description = "The master password for the DocumentDB cluster"
  type        = string
  sensitive   = true
}

variable "docdb_cluster_endpoint" {
  description = "The connection endpoint for the DocumentDB cluster"
  type        = string
}

variable "docdb_cluster_port" {
  description = "The port for the DocumentDB cluster"
  type        = number
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
