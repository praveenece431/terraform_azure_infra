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

variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account. Must be unique across all of Azure."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account (e.g., Standard, Premium)."
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account (e.g., LRS, GRS, ZRS, etc.)."
}

variable "app_name" {
  type        = string
  description = "Defines the tag name to use for this storage account."
}

variable "environment" {
  type        = string
  description = "Defines the env name to use for this storage account."
}

variable "container_name" {
  type        = string
  description = "Defines the name of the container"
}

variable "fileshare_name" {
  type        = string
  description = "Defines the name of the fileshare"
}
### ACR
variable "acr_name" {
  type = string
}

#AKS
variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes for the AKS cluster."
  default     = 2
  type        = number
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "client_id" {
  description = "The client_id for AKS cluster creation."
  type        = string
}

variable "client_secret" {
  description = "The client_secret for AKS cluster creation."
  type        = string
}

variable "min_node_count" {
  description = "Size of the Azure VM"
  type        = string
}

variable "pool_name" {
  description = "Name of the pool"
  type        = string
}

variable "max_node_count" {
  description = "Size of the Azure VM"
  type        = string
}

variable "enable_auto_scaling" {
  description = "Size of the Azure VM"
  type        = bool
}