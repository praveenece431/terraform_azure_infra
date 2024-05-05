output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
  description = "Kubeconfig file for connecting to the Kubernetes cluster."
}

output "aks_node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "The auto-generated resource group which contains the resources for this AKS cluster."
}
