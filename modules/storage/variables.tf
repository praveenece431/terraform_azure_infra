variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account. Must be unique across all of Azure."
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account (e.g., Standard, Premium)."
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account (e.g., LRS, GRS, ZRS, etc.)."
}

variable "container_name" {
  type = string
  description = "Defines the name of the container"
}

variable "fileshare_name" {
  type = string
  description = "Defines the name of the fileshare"
}