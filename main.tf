module "jenkins_master" {
  source              = "./modules/jenkins_vm"
  vm_name             = "jenkins-master"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_size             = var.vm_size
  username            = var.username
  password            = var.password
  is_master           = true
}

module "jenkins_slave" {
  source              = "./modules/jenkins_vm"
  vm_name             = "jenkins-slave"
  resource_group_name = var.resource_group_name
  location            = var.location
  vm_size             = var.vm_size
  username            = var.username
  password            = var.password
  is_master           = false
  master_ip           = module.jenkins_master.vm_ip
}

output "master_ip" {
  value = module.jenkins_master.vm_ip
}

output "slave_ip" {
  value = module.jenkins_slave.vm_ip
}