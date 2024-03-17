

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

variable "backup_jumpbox_subnet_id" {
  type = string
}

# variable "cosmos_primary_connection_tring" {
#   type      = string
#   sensitive = true
# }

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

provider "azurerm" {
  alias           = "secondary"
  features {}
  subscription_id = "2c22ccdb-ba3a-45b0-b2f7-70cc02a39b0a"
}

data "azurerm_dns_zone" "dns_zone" {
  provider            = azurerm.secondary
  count               = var.dns_zone_name != null && var.dns_zone_resource_group_name != null ? 1 : 0
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group_name
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
  
  aks_private_dns_zone_id      = var.aks_private_dns_zone_id
  

  web_app_routing                         = {
                                            enabled     = true
                                            dns_zone_id = length(data.azurerm_dns_zone.dns_zone) > 0 ? element(data.azurerm_dns_zone.dns_zone[*].id, 0) : ""
                                          }

  tags = var.tags

}

module "app_registration" {
  source               = "../modules/app-registration"
  root_name            = local.workload_name
  oidc_issuer_url      = module.aks.oidc_issuer_url
  aks_namespace        = local.aks_namespace
  service_account_name = local.app_registration_service_account_name
}


# module "kv" {
#   source                          = "../modules/keyvault"
#   root_name                       = local.workload_name
#   resource_group_name             = module.group.name
#   location                        = var.location
#   aks_subnet_id                   = var.aks_Pod_id
#   jumpbox_subnet_id               = var.jumpbox_subnet_id
#   backup_jumpbox_subnet_id        = var.backup_jumpbox_subnet_id
#   aks_service_principal_object_id = module.app_registration.aks_service_principal_object_id
#   cosmos_connection_string        = var.cosmos_primary_connection_tring
#   tags                            = var.tags
# }
