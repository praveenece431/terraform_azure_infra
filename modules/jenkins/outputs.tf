output "jenkins_master_ip" {
  description = "Public IP of Jenkins Master"
  value       = var.master_ip
}

output "jenkins_slave_ip" {
  description = "Public IP of Jenkins Slave"
  value       = var.slave_ip
}