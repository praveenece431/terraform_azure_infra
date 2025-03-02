output "vm_public_ips" {
  description = "Public IP addresses of the created virtual machines"
  value       = azurerm_linux_virtual_machine.vm[*].public_ip_address
}