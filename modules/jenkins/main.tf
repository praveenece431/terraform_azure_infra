resource "null_resource" "jenkins_master" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = tls_private_key.ssh_key.private_key_pem # ✅ Use dynamically generated private key
      host        = azurerm_linux_virtual_machine.vm[0].public_ip_address
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y openjdk-11-jdk",
      "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -",
      "sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'",
      "sudo apt update -y",
      "sudo apt install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
    ]
  }
}

resource "null_resource" "jenkins_slave" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = tls_private_key.ssh_key.private_key_pem # ✅ Use dynamically generated private key
      host        = azurerm_linux_virtual_machine.vm[1].public_ip_address
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y openjdk-11-jdk",
      "sudo useradd -m -s /bin/bash jenkins-slave",
      "sudo mkdir -p /home/jenkins-slave/.ssh",
      "sudo echo '${tls_private_key.ssh_key.public_key_openssh}' > /home/jenkins-slave/.ssh/authorized_keys",
      "sudo chown -R jenkins-slave:jenkins-slave /home/jenkins-slave/.ssh",
      "sudo chmod 600 /home/jenkins-slave/.ssh/authorized_keys"
    ]
  }
}