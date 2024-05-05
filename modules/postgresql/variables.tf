variable "resource_group" {
   type = string
   description = "The name of the resource group in which to create the PostgreSQL server."
}

variable "location" {
 description = "The location/region where the server and database are created."
  type        = string
}

variable "postgresql_server_name" {
  type        = string
  description = "The name of the PostgreSQL server."
}

variable "postgresql_version" {
  type        = string
  description = "The version of PostgreSQL to use."
  default     = "11"
}

variable "admin_username" {
  type        = string
  description = "Admin username for PostgreSQL server."
}

variable "admin_password" {
  type        = string
  description = "Admin password for PostgreSQL server."
  sensitive   = true
}

variable "sku_name" {
  type        = string
  description = "The SKU name for the PostgreSQL server."
  default     = "B_Gen5_2"
}

variable "storage_mb" {
  type        = number
  description = "Max storage allowed for the PostgreSQL server (in MB)."
  default     = 5120  # 5GB
}

variable "backup_retention_days" {
  type        = number
  description = "Backup retention days for the PostgreSQL server."
  default     = 7
}

variable "auto_grow_enabled" {
  type        = bool
  description = "Enable/Disable auto growing of the storage."
  default     = true
}

variable "database_name" {
  type        = string
  description = "The name of the database to create in the PostgreSQL server."
  default     = "dev_app_db"
}
