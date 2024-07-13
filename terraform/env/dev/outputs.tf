output "aws_vpc_id" {
  value = module.network.vpc_id
}

output "aws_subnet_ids" {
  value = module.network.subnet_ids
}

output "azure_vnet_id" {
  value = module.network.vnet_id
}

output "azure_subnet_ids" {
  value = module.network.subnet_ids
}