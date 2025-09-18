variable "vpc_id" {
  description = "The ID of the VPC where DocumentDB will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the DocumentDB cluster"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "The security group ID of the ECS tasks that need to connect to DocumentDB"
  type        = string
}

variable "docdb_master_username" {
  description = "The master username for the DocumentDB cluster"
  type        = string
}

variable "docdb_master_password" {
  description = "The master password for the DocumentDB cluster"
  type        = string
  sensitive   = true
}

variable "docdb_instance_count" {
  description = "The number of DocumentDB instances in the cluster"
  type        = number
  default     = 1
}

variable "docdb_instance_class" {
  description = "The instance class for the DocumentDB instances"
  type        = string
  default     = "db.t3.medium"
}