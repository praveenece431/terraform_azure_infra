resource "null_resource" "jenkins_master" {
  depends_on = [var.vm_master_id]

  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("~/.ssh/id_rsa")
    host        = var.master_ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/install_jenkins_master.sh"
  }
}

resource "null_resource" "jenkins_slave" {
  depends_on = [null_resource.jenkins_master]

  connection {
    type        = "ssh"
    user        = "azureuser"
    private_key = file("~/.ssh/id_rsa")
    host        = var.slave_ip
  }

  provisioner "remote-exec" {
    script = "${path.module}/install_jenkins_slave.sh"
  }
}
