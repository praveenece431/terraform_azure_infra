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
  vm_names  = var.vm_names
  subnet_id = module.network.subnet_id
}

module "storage" {
  source                   = "./modules/storage"
  storage_account_name     = var.storage_account_name
  resource_group           = data.azurerm_resource_group.resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  fileshare_name           = var.fileshare_name
  container_name           = var.container_name
}

module "acr" {
  source         = "./modules/acr"
  acr_name       = var.acr_name
  resource_group = data.azurerm_resource_group.resource_group.name
  location       = var.location
}

module "aks" {
  source              = "./modules/aks"
  cluster_name        = var.cluster_name
  resource_group      = data.azurerm_resource_group.resource_group.name
  location            = var.location
  node_count          = var.node_count
  pool_name           = var.pool_name
  enable_auto_scaling = var.enable_auto_scaling
  vm_size             = var.vm_size
  min_node_count      = var.min_node_count
  max_node_count      = var.max_node_count
  kubernetes_version  = var.kubernetes_version
  depends_on = [
    module.acr
  ]
}

module "postgresql" {
  source                 = "./modules/postgresql"
  postgresql_server_name = var.postgresql_server_name
  resource_group         = data.azurerm_resource_group.resource_group.name
  location               = var.location
  postgresql_version     = var.postgresql_version
  admin_username         = var.admin_username
  admin_password         = var.admin_password
  sku_name               = var.sku_name
  storage_mb             = var.storage_mb
  backup_retention_days  = var.backup_retention_days
  auto_grow_enabled      = var.auto_grow_enabled
  depends_on = [
    module.aks
  ]
}