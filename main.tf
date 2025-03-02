resource "azurerm_resource_group" "rg" {
  name     = "tfJenkins-dev"
  location = "East US"  # Change to your preferred location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "tfJenkinsVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "tfJenkinsSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  count               = 1
  name                = "tfJenkinsPublicIP-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  count               = 1
  name                = "tfJenkinsNIC-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "tfJenkinsNSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "jenkins_rule" {
  name                        = "Allow-Jenkins"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = 1
  name                            = "tfJenkinsVM-${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "azureuser"
  admin_password                  = "Devops@12345"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"  # Specify the storage account type
    disk_size_gb        = 30                  # Specify the disk size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209050"
  }

  provision_vm_agent = true

  depends_on = [azurerm_public_ip.public_ip]  # Ensure public IPs are created before VM provisioning
}

resource "null_resource" "provision_jenkins" {
  count = 1

  provisioner "remote-exec" {
  inline = [
    "set -e",  # Stop on the first error
    "sudo apt update",
    "sudo apt install openjdk-11-jdk -y",
    "wget https://get.jenkins.io/war-stable/latest/jenkins.war",
    "wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.100/bin/apache-tomcat-9.0.100.tar.gz",
    "tar -xvf apache-tomcat-9.0.100.tar.gz",
    "mv apache-tomcat-9.0.100 tomcat",
    "echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc",
    "source ~/.bashrc",
    "sudo mv jenkins.war tomcat/webapps/",
    "sudo ./tomcat/bin/startup.sh",
    "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
  ]

  connection {
    type     = "ssh"
    user     = "azureuser"
    password = "Devops@12345"
    host     = azurerm_public_ip.public_ip[count.index].ip_address
  }

}

  depends_on = [azurerm_linux_virtual_machine.vm, azurerm_public_ip.public_ip]  # Ensure VMs are created before provisioning
}

output "public_ips" {
  value = azurerm_public_ip.public_ip[*].ip_address
}