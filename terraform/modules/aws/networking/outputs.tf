output "vpc_id" {
  description = "The ID of the VPC in the bespoke-crm project"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets in the bespoke-crm project"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets in the bespoke-crm project"
  value       = aws_subnet.private[*].id
}
