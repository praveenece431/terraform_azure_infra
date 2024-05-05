output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "The name of the storage account."
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.storage.primary_access_key
  description = "The primary access key for the storage account."
  sensitive = true
}


# Output for Blob Container
output "blob_container_id" {
  value       = azurerm_storage_container.container.id
  description = "The ID of the blob container."
}

# Output for File Share
output "file_share_id" {
  value       = azurerm_storage_share.fileshare.id
  description = "The ID of the file share."
}