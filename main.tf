# locals {
#   resource_name = "mabc"
# }

module "network" {
  source = "./modules/network"
  #resource_group = var.resource_group
  resource_group = data.azurerm_resource_group.resource_group.name
  location       = var.location
  vnet_name      = var.vnet_name
  subnet_name    = var.subnet_name
  address_space  = var.address_space
  subnet_prefix  = var.subnet_prefix
}

module "vm" {
  source         = "./modules/vm"
  resource_group = data.azurerm_resource_group.resource_group.name
  location       = var.location
  vm_size        = var.vm_size
#   vm_count       = var.vm_count
  vm_names       = var.vm_names
  subnet_id      = module.network.subnet_id
}