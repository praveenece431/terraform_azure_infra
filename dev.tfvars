# Resource Group and Location
app_name       = "myapp"
environment    = "dev"
resource_group = "dev-rg"
location       = "East US"

# Virtual Machine Configuration
vm_names = ["Jenkins"]
vm_size  = "Standard_D2s_v3" # Smaller size for development
#vm_count = 3              # Typically fewer instances in development

# Networking Configuration
vnet_name     = "dev-vnet"
subnet_name   = "dev-subnet"
address_space = ["10.0.0.0/16"]
subnet_prefix = ["10.0.1.0/24"]

#Storage variabels:
account_tier             = "Standard"
storage_account_name     = "myappstorage431"
account_replication_type = "GRS"
container_name           = "app-container"
fileshare_name           = "app-fileshare"

# ACR 
acr_name = "devregistry431"

#AKS
cluster_name        = "dev-aks"
enable_auto_scaling = false
pool_name           = "devpoolaks"
node_count          = "1"
min_node_count      = "2"
max_node_count      = "4"
kubernetes_version  = "1.28.5"
client_id           = "6fbfda2a-02d5-4ede-a0cd-6bc9524f2782"
client_secret       = "NdI8Q~3rmmDZ0p3OCAjg4_Sz6B-TraCZ~Vt2scVn"

# PostgreSQL 
postgresql_server_name = "dev-bandla-db"
postgresql_version     = "10"
admin_username         = "dev_user"
admin_password         = "sggmrgr#mc@_4ApP$32G"
sku_name               = "GP_Gen5_2"
storage_mb             = "5120"
backup_retention_days  = "7"
auto_grow_enabled      = true
database_name          = "dev_app_db"