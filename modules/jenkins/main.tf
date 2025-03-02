resource "null_resource" "jenkins_master" {
  provisioner "remote-exec" {
    connection {
      host        = var.master_ip # ✅ Fix: Use master_ip directly
      user        = "azureuser"
      private_key = var.ssh_private_key
    }

    inline = [
      "sudo apt update -y",
      "wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc",
      "echo \"deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main\" | sudo tee /etc/apt/sources.list.d/adoptium.list",
      "sudo apt update -y",
      "sudo apt install temurin-17-jdk -y",
      "/usr/bin/java --version",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install jenkins -y",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl status jenkins"
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
      "#sudo useradd -m -s /bin/bash jenkins-slave",
      "#sudo mkdir -p /home/jenkins-slave/.ssh",
      "#sudo chown -R jenkins-slave:jenkins-slave /home/jenkins-slave/.ssh",
      "#echo '${var.ssh_public_key}' | sudo tee /home/jenkins-slave/.ssh/authorized_keys"
    ]
  }
}