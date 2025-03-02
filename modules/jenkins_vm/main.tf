resource "azurerm_virtual_network" "example" {
  name                = "${var.vm_name}-vnet"
  address_space        = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "example" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "example" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size         # vm_size instead of size
  admin_username        = var.username         # admin_username instead of username
  admin_password        = var.password         # admin_password instead of password

  # Add the storage_os_disk block
  storage_os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    create_option        = "FromImage"
    managed              = true

    # Image reference inside storage_os_disk
    source_image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-DAILY-LTS"
      version   = "18.04.202306070"
  }
  }

  # Provisioning the machine
  provisioner "remote-exec" {
    inline = var.is_master ? [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk wget",
      "wget -q -O /tmp/jenkins.war https://get.jenkins.io/war/2.319.1/jenkins.war",
      "nohup java -jar /tmp/jenkins.war &"
    ] : [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk wget",
      "wget -q -O /tmp/jenkins-agent.jar https://get.jenkins.io/war/2.319.1/jenkins.war",
      "java -jar /tmp/jenkins-agent.jar -jnlpUrl http://${var.master_ip}:8080/computer/$(hostname)/slave-agent.jnlp -secret ${var.secret}"
    ]

    connection {
      type        = "ssh"
      host        = azurerm_public_ip.example.ip_address
      user        = var.username
      private_key = file("~/.ssh/id_rsa")
    }
  }

  tags = {
    environment = "development"
  }
}

output "vm_ip" {
  value = azurerm_public_ip.example.ip_address
}