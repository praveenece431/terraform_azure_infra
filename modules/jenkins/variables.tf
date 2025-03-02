variable "ssh_private_key" {
  description = "Private SSH key for connecting to VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for configuring SSH access"
  type        = string
}

variable "master_ip" {
  description = "Public IP address of the Jenkins master VM"
  type        = string
}

variable "slave_ip" {
  description = "Public IP address of the Jenkins slave VM"
  type        = string
}
