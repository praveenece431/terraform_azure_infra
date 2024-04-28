variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy the resources"
  type        = string
}

variable "vm_size" {
  description = "Size of the Azure VM"
  type        = string
}

variable "vm_names" {
  type = list(string)
}

# variable "vm_count" {
#   description = "Number of VM instances to create"
#   type        = number
# }

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet within the virtual network"
  type        = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_prefix" {
  type = list(string)
}
