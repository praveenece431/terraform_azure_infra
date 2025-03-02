resource "null_resource" "jenkins_master" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = var.ssh_private_key # ✅ Use input variable from compute module
      host        = var.vm_public_ips[0] # ✅ Use input variable from compute module
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
      private_key = var.ssh_private_key # ✅ Use input variable from compute module
      host        = var.vm_public_ips[1] # ✅ Use input variable from compute module
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y openjdk-11-jdk",
      "sudo useradd -m -s /bin/bash jenkins-slave",
      "sudo mkdir -p /home/jenkins-slave/.ssh",
      "echo '${var.ssh_public_key}' | sudo tee /home/jenkins-slave/.ssh/authorized_keys",
      "sudo chown -R jenkins-slave:jenkins-slave /home/jenkins-slave/.ssh",
      "sudo chmod 600 /home/jenkins-slave/.ssh/authorized_keys"
    ]
  }
}