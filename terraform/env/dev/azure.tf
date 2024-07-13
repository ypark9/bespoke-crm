terraform {
  backend "azurerm" {
    storage_account_name = "tfstate"
    container_name       = "tfstate"
    key                  = "env/dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source      = "../../modules/azure/network"
  vnet_cidr   = "10.0.0.0/16"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

output "azure_vnet_id" {
  value = module.network.vnet_id
}

output "azure_subnet_ids" {
  value = module.network.subnet_ids
}