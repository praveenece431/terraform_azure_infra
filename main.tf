module "network" {
  source               = "./modules/network"
  resource_group_name  = "terraform-rg"
  location             = "East US"
}

module "compute" {
  source               = "./modules/compute"
  resource_group_name  = module.network.resource_group_name
  location             = module.network.location
  subnet_id            = module.network.subnet_id
}

module "jenkins" {
  source      = "./modules/jenkins"

  master_ip    = module.compute.vm_public_ips[0] # Master IP from compute module
  slave_ip     = module.compute.vm_public_ips[1] # Slave IP from compute module
  ssh_private_key = module.compute.ssh_private_key
  ssh_public_key  = module.compute.ssh_public_key
}