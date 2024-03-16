resource "azurerm_user_assigned_identity" "aks_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  name = "${var.root_name}Identity"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

data "azurerm_resource_group" "existing" {
  name = var.vnetrg
}

resource "azurerm_role_assignment" "network_contributor_assignment" {
  scope                = data.azurerm_resource_group.existing.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_kubernetes_cluster" "default" {
  name                    = "aks-${var.root_name}"
  resource_group_name     = var.resource_group_name
  location                = var.location
  dns_prefix              = "aks-${var.root_name}"
  node_resource_group     = "rg-k8s-${var.root_name}"
  private_cluster_enabled = true
  oidc_issuer_enabled     = true


  default_node_pool {
    name           = var.default_namespace
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.aks_System_id
  }

  ingress_application_gateway {

    gateway_name = "agw-${var.root_name}"
    subnet_id    = var.gateway_subnet_id
    
  }
    identity {
      type = "UserAssigned"
      identity_ids = tolist([azurerm_user_assigned_identity.aks_identity.id])
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.0.10"
    # docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"
  }

  api_server_access_profile {
    vnet_integration_enabled = true
    subnet_id = var.aks_ApiServer_id
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }



  tags = var.tags
}


# resource "azurerm_monitor_diagnostic_setting" "application_gateway" {
#   name                       = "Application Gateway Logs"
#   target_resource_id         = azurerm_kubernetes_cluster.default.ingress_application_gateway[0].effective_gateway_id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   log {
#     category = "ApplicationGatewayAccessLog"
#     enabled  = true

#     retention_policy {
#       days    = 7
#       enabled = true
#     }
#   }

#   log {
#     category = "ApplicationGatewayPerformanceLog"
#     enabled  = true

#     retention_policy {
#       days    = 7
#       enabled = true
#     }
#   }

#   log {
#     category = "ApplicationGatewayFirewallLog"
#     enabled  = true

#     retention_policy {
#       days    = 7
#       enabled = true
#     }
#   }

#   metric {
#     category = "AllMetrics"
#     enabled  = true

#     retention_policy {
#       days    = 7
#       enabled = true
#     }
#   }

# }

data "azurerm_public_ip" "default" {
  name                = "agw-${var.root_name}-appgwpip"
  resource_group_name = azurerm_kubernetes_cluster.default.node_resource_group

  depends_on = [
    azurerm_kubernetes_cluster.default
  ]
}
