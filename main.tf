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
  master_ip   = module.compute.vm_public_ips[0]
  slave_ip    = module.compute.vm_public_ips[1]
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "ssh_public_key" {
  value = tls_private_key.ssh_key.public_key_openssh
}

output "ssh_private_key" {
  value     = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}
