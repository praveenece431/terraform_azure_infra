output "vm_public_ips" {
  value = module.vm.vm_public_ips
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}


output "storage_account_primary_access_key" {
  value       = module.storage.storage_account_primary_access_key
  description = "The primary access key for the storage account."
  sensitive = true
}
