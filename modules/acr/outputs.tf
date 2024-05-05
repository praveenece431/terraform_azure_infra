# Output for Azure Container Registry
output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The login server URL of the container registry."
}

output "acr_admin_username" {
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = false
  description = "The admin username for the container registry."
}

output "acr_admin_password" {
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
  description = "The admin password for the container registry."
}

