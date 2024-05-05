resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = {
    Environment = "dev"
  }
}

# Create a blob container within the storage account
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.storage
  ]
}

# Create a file share within the storage account
resource "azurerm_storage_share" "fileshare" {
  name                 = var.fileshare_name
  storage_account_name = azurerm_storage_account.storage.name

  # Define the quota of the file share in GB
  quota                = 100
   depends_on = [
    azurerm_storage_account.storage
  ]
}