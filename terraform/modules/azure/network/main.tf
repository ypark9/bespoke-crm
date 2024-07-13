variable "vnet_cidr" {
  description = "The CIDR block for the VNet"
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vnet_cidr))
    error_message = "The VNet CIDR block must be a valid CIDR."
  }
}

variable "subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "East US" # Adjust the location as necessary
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-main"
  address_space       = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_cidrs)
  name                 = format("subnet-%02d", count.index + 1)
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [element(var.subnet_cidrs, count.index)]
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = [for s in azurerm_subnet.subnets : s.id]
}