variable "resource_group" {
   type = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The location where the AKS cluster will be created."
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes for the AKS cluster."
  default     = 3
  type        = number
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "vm_size" {
  description = "Size of the Azure VM"
  type        = string
}

variable "pool_name" {
  description = "Name of the pool"
  type        = string
}

variable "min_node_count" {
  description = "Size of the Azure VM"
  type        = string
}

variable "max_node_count" {
  description = "Size of the Azure VM"
  type        = string
}

variable "enable_auto_scaling" {
  description = "To disable or enable_auto_scaling"
  type        = bool
}