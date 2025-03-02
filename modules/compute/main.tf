resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 2
  name                  = "vm-${count.index}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_B2s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
}

resource "azurerm_network_interface" "nic" {
  count               = 1
  name                = "nic-${count.index}"
  resource_group_name = var.resource_group_name
  location           = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_public_ip" "public_ip" {
  count               = 1
  name                = "public-ip-${count.index}"
  resource_group_name = var.resource_group_name
  location           = var.location
  allocation_method  = "Dynamic"
}

output "ssh_public_key" {
  description = "The SSH public key"
  value       = tls_private_key.ssh_key.public_key_openssh
}

output "ssh_private_key" {
  description = "The SSH private key (keep it safe!)"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = false
}