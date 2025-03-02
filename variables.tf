variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "terraform-rg"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "East US"
}