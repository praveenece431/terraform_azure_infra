# variable "vm_count" {
#   type = number
# }

variable "vm_names" {
  type        = list(string) 
}

variable "location" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "subnet_id" {
  type = string
}
