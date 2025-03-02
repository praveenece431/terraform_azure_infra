module "jenkins_master" {
  source              = "./modules/jenkins_vm"
  vm_name             = "jenkins-master"
  location           = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size
  username            = var.username
  is_master           = true
  master_ip           = azurerm_public_ip.jenkins_master.ip_address
  secret              = var.secret   # Pass the secret variable here
  ssh_public_key_path = "~/.ssh/id_rsa.pub"
}

output "master_ip" {
  value = module.jenkins_master.vm_ip
}

output "slave_ip" {
  value = module.jenkins_slave.vm_ip
}