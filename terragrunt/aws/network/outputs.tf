output "vpc_id" {
  description = "The VPC ID"
  value       = module.feedback_cronjob_vpc.vpc_id
}

output "vpc_private_subnet_ids" {
  description = "List of private subnet IDs for the feedback cronjob VPC"
  value       = module.feedback_cronjob_vpc.private_subnet_ids
}

output "vpc_public_subnet_ids" {
  description = "List of public subnet IDs for the feedback cronjob VPC"
  value       = module.feedback_cronjob_vpc.public_subnet_ids
}

output "vpc_cidr_block" {
  description = "CIDR block for the feedback cronjob VPC"
  value       = module.feedback_cronjob_vpc.cidr_block
}