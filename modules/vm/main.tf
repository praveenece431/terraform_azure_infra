resource "azurerm_virtual_machine" "vm" {
  count                = length(var.vm_names)
  name                  =  "${var.vm_names[count.index]}-OsDisk"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_names[count.index]}-OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.vm_names[count.index]
    admin_username = "azureuser"
    admin_password = "AzureAdmin1234"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
####################

resource "azurerm_public_ip" "public_ip" {
  count = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-PubIP"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  count = length(var.vm_names)
  #count               = var.vm_count
  name                = "${var.vm_names[count.index]}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    #name                          = "testconfiguration${count.index}"
    name = "${var.vm_names[count.index]}-ipConfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}