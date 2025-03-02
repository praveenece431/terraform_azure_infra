output "vm_public_ips" {
  description = "Public IP addresses of the created virtual machines"
  value       = azurerm_linux_virtual_machine.vm[*].public_ip_address
}

output "vm_public_ips" {
  value = [azurerm_linux_virtual_machine.vm[0].public_ip_address, azurerm_linux_virtual_machine.vm[1].public_ip_address]
}

output "ssh_private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

output "ssh_public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}