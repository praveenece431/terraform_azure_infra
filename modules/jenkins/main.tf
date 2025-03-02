resource "null_resource" "jenkins_master" {
  provisioner "remote-exec" {
    connection {
      host        = var.master_ip # ✅ Fix: Use master_ip directly
      user        = "azureuser"
      private_key = var.ssh_private_key
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y openjdk-11-jdk",
      "sudo apt install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}

resource "null_resource" "jenkins_slave" {
  provisioner "remote-exec" {
    connection {
      host        = var.slave_ip # ✅ Fix: Use slave_ip directly
      user        = "azureuser"
      private_key = var.ssh_private_key
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y openjdk-11-jdk",
      "sudo useradd -m -s /bin/bash jenkins-slave",
      "sudo mkdir -p /home/jenkins-slave/.ssh",
      "sudo chown -R jenkins-slave:jenkins-slave /home/jenkins-slave/.ssh",
      "echo '${var.ssh_public_key}' | sudo tee /home/jenkins-slave/.ssh/authorized_keys"
    ]
  }
}