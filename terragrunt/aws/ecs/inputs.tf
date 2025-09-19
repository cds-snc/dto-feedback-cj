variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  type        = string
}

variable "fargate_cpu" {
  description = "Fargate CPU units for the cronjob"
  type        = number
  default     = 2048 # 2 vCPU for processing 150+ records
}

variable "fargate_memory" {
  description = "Fargate Memory units for the cronjob"
  type        = number
  default     = 4096 # 4GB RAM for batch processing
}

variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
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
# Airtable Base ID SSM Parameter ARNs (sensitive data)

variable "airtable_base_arn" {
  description = "ARN of the main Airtable base SSM parameter"
  type        = string
}

variable "health_airtable_base_arn" {
  description = "ARN of the health Airtable base SSM parameter"
  type        = string
}

variable "cra_airtable_base_arn" {
  description = "ARN of the CRA Airtable base SSM parameter"
  type        = string
}

variable "travel_airtable_base_arn" {
  description = "ARN of the travel Airtable base SSM parameter"
  type        = string
}

variable "ircc_airtable_base_arn" {
  description = "ARN of the IRCC Airtable base SSM parameter"
  type        = string
}

variable "aws_docdb_security_group_id" {
  description = "Security group of the DocumentDB database"
  type        = string
}

variable "docdb_uri_arn" {
  description = "ARN of the Document DB URI parameter"
  type        = string
}