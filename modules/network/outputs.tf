output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
  description = "The ID of the virtual network"
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
  description = "The name of the virtual network"
}

output "vnet_address_space" {
  value = azurerm_virtual_network.vnet.address_space
  description = "The address space of the virtual network"
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
  description = "The ID of the subnet"
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
  description = "The name of the subnet"
}

output "subnet_address_prefix" {
  value = azurerm_subnet.subnet.address_prefixes
  description = "The address prefix of the subnet"
}
