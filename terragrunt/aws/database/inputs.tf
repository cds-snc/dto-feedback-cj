variable "vpc_id" {
  description = "The VPC id of the feedback cronjob app"
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "The private subnet ids of the VPC"
  type        = list(any)
}

variable "vpc_cidr_block" {
  description = "The cidr block of the VPC"
  type        = string
}

variable "docdb_username_name" {
  description = "The SSM parameter name containing the username for the DocumentDB cluster"
  type        = string
}

variable "docdb_password_name" {
  description = "The SSM parameter name containing the password for the DocumentDB cluster"
  type        = string
}

variable "docdb_instance_count" {
  description = "The number of instances in the DocumentDB cluster"
  type        = number
  default     = 1
}

variable "docdb_instance_class" {
  description = "The instance class for DocumentDB instances"
  type        = string
  default     = "db.t3.medium"
}