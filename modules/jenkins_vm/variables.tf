variable "vm_name" {
  description = "The name of the VM."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "secret" {
  description = "The secret for the Jenkins agent to connect to the master."
  type        = string
  sensitive   = true  # Marking this variable as sensitive to avoid logging in plan/apply
}

variable "location" {
  description = "Azure location where resources will be deployed."
  type        = string
}

variable "vm_size" {
  description = "Size of the Azure Virtual Machine."
  type        = string
}

variable "username" {
  description = "Admin username for the VM."
  type        = string
}

variable "password" {
  description = "Admin password for the VM."
  type        = string
}

variable "is_master" {
  description = "Indicates if this VM is a Jenkins master."
  type        = bool
}

variable "master_ip" {
  description = "The public IP address of the Jenkins master (required for slaves)."
  type        = string
  default     = ""
}