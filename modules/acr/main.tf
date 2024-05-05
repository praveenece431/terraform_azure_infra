resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group
  location                 = var.location
  sku                      = "Standard"  # Options are Basic, Standard, and Premium
  admin_enabled            = true        # Enables admin user that has push/pull permission to the registry

  #georeplications {
   # location = "East US"
   # tags = {
   #   env = "replica"
   # }
 # }

  tags = {
    Environment = "dev"
  }
}
