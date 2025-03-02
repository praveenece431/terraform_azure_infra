# modules/jenkins_vm/main.tf

resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = var.vm_size

  admin_username        = var.username

  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_public_key_path)  # Use ssh_public_key_path here
  }

  storage_os_disk {
    name          = "${var.vm_name}-osdisk"
    caching       = "ReadWrite"
    create_option = "FromImage"

    image_reference {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "20.04-LTS"
      version   = "latest"
    }
  }

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
}