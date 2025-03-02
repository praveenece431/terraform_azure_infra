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
  source = "./modules/jenkins"

  vm_public_ips  = module.compute.vm_public_ips
  ssh_private_key = module.compute.ssh_private_key
  ssh_public_key  = module.compute.ssh_public_key
}
