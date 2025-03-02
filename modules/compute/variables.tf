variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be deployed"
  type        = string
}