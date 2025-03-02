output "jenkins_master_ip" {
  description = "Public IP address of the Jenkins Master VM"
  value       = var.master_ip
}

output "jenkins_slave_ip" {
  description = "Public IP address of the Jenkins Slave VM"
  value       = var.slave_ip
}