

variable "application_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "instance" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}

variable "aks_System_id" {
  type = string
}

variable "aks_Pod_id" {
  type = string
}

variable "aks_User_id" {
  type = string
}

variable "aks_ApiServer_id" {
  type = string
}

variable "jumpbox_subnet_id" {
  type = string
}

variable "Main_hub_subnet_id" {
  type = string
  default = "/subscriptions/2c22ccdb-ba3a-45b0-b2f7-70cc02a39b0a/resourceGroups/MAHB-connectivity/providers/Microsoft.Network/virtualNetworks/MAHB-hub-southeastasia/subnets/Management_Subnet"
}


variable "backup_jumpbox_subnet_id" {
  type = string
}

variable "cosmos_primary_connection_tring" {
  type      = string
  sensitive = true
}

variable "aks_vm_size" {
  type = string
}

variable "aks_node_count" {
  type = number
}

variable "tags" {
  type = map(string)
}

variable "dns_zone_name" {
  description = "Specifies the name of the DNS zone."
  type = string
}

variable "dns_zone_resource_group_name" {
  description = "Specifies the name of the DNS zone."
  type = string
}

variable "aks_private_dns_zone_id" {
  description = "Specifies the name of the resource group that contains the DNS zone."
  type = string
}

# variable "web_app_routing_enabled" {
#   description = "(Optional) Should Web App Routing be enabled?"
#   type        = bool
# }

# variable "web_app_routing" {
#   description   = "Specifies the Application HTTP Routing addon configuration."
#   type          = object({
#     enabled     = bool
#     dns_zone_id = string
#   })
#   default       = {
#     enabled     = false           
#     dns_zone_id = null
#   }
# }

# provider "azurerm" {
#   alias           = "secondary"
#   features {}
#   subscription_id = "2c22ccdb-ba3a-45b0-b2f7-70cc02a39b0a"
# }

# data "azurerm_dns_zone" "dns_zone" {
#   provider            = azurerm.secondary
#   count               = var.dns_zone_name != null && var.dns_zone_resource_group_name != null ? 1 : 0
#   name                = var.dns_zone_name
#   resource_group_name = var.dns_zone_resource_group_name
# }


variable "user_node_pool_name" {
  description = "(Required) Specifies the name of the node pool."
  type        = string
  default     = "user"
}

variable "user_node_pool_vm_size" {
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard_F8s_v2"
}

variable "user_node_pool_availability_zones" {
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
  type        = list(string)
  default = ["1", "2", "3"]
}

variable "user_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type          = bool
  default       = true
}

variable "user_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type          = bool
  default       = false
} 

variable "user_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type          = bool
  default       = false
} 

variable "user_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type          = number
  default       = 50
}

variable "user_node_pool_mode" {
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
  type          = string
  default       = "User"
} 

variable "user_node_pool_node_labels" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

variable "user_node_pool_node_taints" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = list(string)
  default       = []
} 

variable "user_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type          = string
  default       = "Ephemeral"
} 

variable "user_node_pool_os_type" {
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
  type          = string
  default       = "Linux"
} 

variable "user_node_pool_priority" {
  description = "(Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  type          = string
  default       = "Regular"
} 

variable "user_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 10
}

variable "user_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 3
}

variable "user_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 3
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  type        = string
  default       = "1.27.9"
}


locals {
  workload_name                         = "${var.application_name}-${var.environment}-${var.instance}"
  vnetrg_name                           = "rg-network-${var.environment}-${var.instance}"
  aks_namespace                         = "default"
  app_registration_service_account_name = "workload-identity-sa"
}

module "group" {
  source    = "../modules/group"
  root_name = local.workload_name
  location  = var.location
  tags      = var.tags
}

module "log" {
  source              = "../modules/log"
  root_name           = local.workload_name
  resource_group_name = module.group.name
  location            = var.location
  tags                = var.tags
}

module "aks" {
  source              = "../modules/aks"
  root_name           = local.workload_name
  vnetrg              = local.vnetrg_name
  resource_group_name = module.group.name
  location            = var.location
  aks_private_dns_zone_id = var.aks_private_dns_zone_id

  default_namespace = local.aks_namespace
  vm_size           = var.aks_vm_size
  node_count        = var.aks_node_count
  aks_System_id     = var.aks_System_id
  aks_User_id       = var.aks_User_id
  aks_Pod_id        = var.aks_Pod_id
  gateway_subnet_id = var.gateway_subnet_id
  aks_ApiServer_id  = var.aks_ApiServer_id
  log_analytics_workspace_id = module.log.id

  network_dns_service_ip    = "10.2.0.10"
  network_plugin            = "azure"
  outbound_type             = "loadBalancer"
  network_service_cidr      = "10.2.0.0/24"

  keda_enabled                     = true
  vertical_pod_autoscaler_enabled  = true
  # web_app_routing_enabled          = true
  
  # web_app_routing                         = {
  #                                           enabled     = true
  #                                           dns_zone_id = length(data.azurerm_dns_zone.dns_zone) > 0 ? element(data.azurerm_dns_zone.dns_zone[*].id, 0) : ""
  #                                         }

  tags = var.tags

}


module "node_pool" {
  source = "../modules/node_pool"
  # resource_group_name         = azurerm_resource_group.rg.name
  kubernetes_cluster_id       = module.aks.id
  name                         = var.user_node_pool_name
  vm_size                      = var.user_node_pool_vm_size
  mode                         = var.user_node_pool_mode
  node_labels                  = var.user_node_pool_node_labels
  node_taints                  = var.user_node_pool_node_taints
  availability_zones           = var.user_node_pool_availability_zones
  vnet_subnet_id               = var.aks_User_id
  pod_subnet_id                = var.aks_Pod_id
  enable_auto_scaling          = var.user_node_pool_enable_auto_scaling
  enable_host_encryption       = var.user_node_pool_enable_host_encryption
  enable_node_public_ip        = var.user_node_pool_enable_node_public_ip
  orchestrator_version         = var.kubernetes_version
  max_pods                     = var.user_node_pool_max_pods
  max_count                    = var.user_node_pool_max_count
  min_count                    = var.user_node_pool_min_count
  node_count                   = var.user_node_pool_node_count
  os_type                      = var.user_node_pool_os_type
  priority                     = var.user_node_pool_priority
  tags                         = var.tags
}

module "app_registration" {
  source               = "../modules/app-registration"
  root_name            = local.workload_name
  oidc_issuer_url      = module.aks.oidc_issuer_url
  aks_namespace        = local.aks_namespace
  service_account_name = local.app_registration_service_account_name
}


module "kv" {
  source                          = "../modules/keyvault"
  root_name                       = local.workload_name
  resource_group_name             = module.group.name
  location                        = var.location
  aks_subnet_id                   = var.aks_Pod_id
  jumpbox_subnet_id               = var.jumpbox_subnet_id
  backup_jumpbox_subnet_id        = var.backup_jumpbox_subnet_id
  Main_hub_subnet_id              = var.Main_hub_subnet_id
  aks_service_principal_object_id = module.app_registration.aks_service_principal_object_id
  cosmos_connection_string        = var.cosmos_primary_connection_tring
  tags                            = var.tags
}


module "helm" {
  source                              = "../../helm"
  # host                                = module.default.host
  username                            = module.aks.username
  password                            = module.aks.password
  # client_key                          = module.aks_cluster.client_key
  # client_certificate                  = module.aks_cluster.client_certificate
  # cluster_ca_certificate              = module.aks_cluster.cluster_ca_certificate
  # namespace                           = var.namespace
  # service_account_name                = var.service_account_name
  # email                               = var.email
  # tenant_id                           = data.azurerm_client_config.current.tenant_id
  # workload_managed_identity_client_id = azurerm_user_assigned_identity.aks_workload_identity.client_id
  # nginx_replica_count                 = 3
}