resource "azurerm_postgresql_server" "postgresql" {
  name                = var.postgresql_server_name
  location            = var.location
  resource_group_name = var.resource_group
  version             = var.postgresql_version
  administrator_login = var.admin_username
  administrator_login_password = var.admin_password
  sku_name            = var.sku_name
  storage_mb          = var.storage_mb
  backup_retention_days = var.backup_retention_days
  geo_redundant_backup_enabled = false
  auto_grow_enabled   = var.auto_grow_enabled

  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "dev_app_db" {
  name                = var.database_name
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
