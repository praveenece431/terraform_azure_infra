output "resource_group_name" {
  description = "The name of the Azure resource group"
  value       = module.network.resource_group_name
}

output "location" {
  description = "The location of the resources"
  value       = module.network.location
}

output "vm_public_ips" {
  description = "Public IP addresses of the created virtual machines"
  value       = module.compute.vm_public_ips
}