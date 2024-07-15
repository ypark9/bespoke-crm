output "vpc_id" {
  description = "The ID of the VPC for the Bespoke CRM project"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets for the Bespoke CRM project"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets for the Bespoke CRM project"
  value       = module.networking.private_subnet_ids
}
