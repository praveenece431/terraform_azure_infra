variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure location where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "Size of the Azure Virtual Machine."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "username" {
  description = "Admin username for the Azure VM."
  type        = string
}

variable "password" {
  description = "Admin password for the Azure VM."
  type        = string
}

variable "jenkins_master_ip" {
  description = "The public IP of the Jenkins master VM."
  type        = string
  default     = ""
}

variable "master_ip" {
  description = "Master VM IP address for connecting Jenkins slave."
  type        = string
  default     = ""
}

variable "secret" {
  description = "The secret for the Jenkins agent to connect to the master."
  type        = string
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key for VM login."
  type        = string
}