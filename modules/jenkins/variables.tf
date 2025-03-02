variable "vm_public_ips" {
  description = "List of public IP addresses for the VMs"
  type        = list(string)
}

variable "ssh_private_key" {
  description = "Private SSH key for connecting to VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key for configuring SSH access"
  type        = string
}