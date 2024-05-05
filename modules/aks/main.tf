resource "azurerm_kubernetes_cluster" "aks" {
 # name                = var.cluster_name
  name = "${var.cluster_name}-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "${var.cluster_name}-dns"
  kubernetes_version  = var.kubernetes_version

  #default_node_pool {
  #  name            = "devpool"
  #  node_count      = var.node_count
  #  vm_size    = var.vm_size
  #  enable_auto_scaling = false
  #}

  default_node_pool {
    name            = var.pool_name
    node_count      = var.node_count
    vm_size    = var.vm_size
    enable_auto_scaling = var.enable_auto_scaling
    #min_count       = var.min_node_count
    #   max_count       = var.max_node_count
  }

  identity {
    type = "SystemAssigned"
  }

 
  # Configure Azure Monitor for Containers
  #addon_profile {
  #  azure_policy {
  #    enabled = true
  #  }
  #}

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    random_string.suffix
  ]
}

resource "random_string" "suffix" {
  length  = 3
  special = false
  upper   = false
}