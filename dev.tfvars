# Resource Group and Location
app_name       = "myapp"
environment    = "dev"
resource_group = "dev-rg"
location       = "East US"

# Virtual Machine Configuration
vm_names = ["server1", "server2"]
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