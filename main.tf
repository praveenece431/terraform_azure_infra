resource "azurerm_public_ip" "jenkins_master" {
  name                = "jenkins-master-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                  = "Basic"
}

module "jenkins_master" {
  source              = "./modules/jenkins_vm"
  vm_name             = "jenkins-master"
  location           = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.vm_size
  username            = var.username
  is_master           = true
  master_ip           = azurerm_public_ip.jenkins_master.ip_address  # Reference the public IP here
  secret              = var.secret
  password            = var.password
  ssh_public_key_path = var.ssh_public_key_path
}


output "master_ip" {
  value = module.jenkins_master.vm_ip
}