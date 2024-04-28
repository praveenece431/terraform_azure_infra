resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  #resource_group_name = data.azurerm_resource_group.resource_group.name
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefix
}
