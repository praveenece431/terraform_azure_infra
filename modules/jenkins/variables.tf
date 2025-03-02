variable "master_ip" {
  description = "Public IP of the Jenkins Master VM"
  type        = string
}

variable "slave_ip" {
  description = "Public IP of the Jenkins Slave VM"
  type        = string
}

variable "vm_master_id" {
  description = "VM ID of the Jenkins Master"
  type        = string
  default     = ""
}