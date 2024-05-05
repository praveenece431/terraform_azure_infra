output "postgresql_server_id" {
  value = azurerm_postgresql_server.postgresql.id
}

output "postgresql_database_id" {
  value = azurerm_postgresql_database.dev_app_db.id
}
