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
  scope                            = data.azurerm_resource_group.existing.id
  role_definition_name             = "Network Contributor"
  principal_id                     = azurerm_user_assigned_identity.aks_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "private_dns" {
  scope                = var.aks_private_dns_zone_id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_identity.principal_id
}

resource "azurerm_kubernetes_cluster" "default" {
  name                    = "aks-${var.root_name}"
  resource_group_name     = var.resource_group_name
  kubernetes_version      = var.kubernetes_version
  location                = var.location
  dns_prefix              = "aks-${var.root_name}"
  node_resource_group     = "rg-k8s-${var.root_name}"
  private_cluster_enabled = true
  oidc_issuer_enabled     = true
  workload_identity_enabled        = true
  private_dns_zone_id     = var.aks_private_dns_zone_id
  local_account_disabled = true
    default_node_pool {
    name                 = var.system_node_pool_name
    vm_size              = var.system_node_pool_vm_size
    vnet_subnet_id       = var.vnet_subnet_id
    pod_subnet_id        = var.pod_subnet_id
    zones                = var.system_node_pool_availability_zones
    orchestrator_version = var.orchestrator_version
    node_labels          = var.system_node_pool_node_labels
    # node_taints             = var.system_node_pool_node_taints
    enable_auto_scaling    = var.system_node_pool_enable_auto_scaling
    enable_host_encryption = var.system_node_pool_enable_host_encryption
    enable_node_public_ip  = var.system_node_pool_enable_node_public_ip
    max_pods               = var.system_node_pool_max_pods
    max_count              = var.system_node_pool_max_count
    min_count              = var.system_node_pool_min_count
    node_count             = var.system_node_pool_node_count
    os_disk_type           = var.system_node_pool_os_disk_type
    tags                   = var.tags
  }
  ingress_application_gateway {

    gateway_name = "agw-${var.root_name}"
    subnet_id    = var.gateway_subnet_id

  }
  identity {
    type         = "UserAssigned"
    identity_ids = tolist([azurerm_user_assigned_identity.aks_identity.id])
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = true
  }

  network_profile {
    dns_service_ip = var.network_dns_service_ip
    network_plugin = var.network_plugin
    outbound_type  = var.outbound_type
    service_cidr   = var.network_service_cidr
  }
  # dynamic "web_app_routing" {
  #   for_each = var.web_app_routing.enabled ? [1] : []

  #   content {
  #     dns_zone_id = var.web_app_routing.dns_zone_id
  #   }
  # }

  api_server_access_profile {
    subnet_id                = var.aks_ApiServer_id
    vnet_integration_enabled = true
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  workload_autoscaler_profile {
    keda_enabled                    = var.keda_enabled
    vertical_pod_autoscaler_enabled = var.vertical_pod_autoscaler_enabled
  }


  tags = var.tags


}


# resource "azurerm_monitor_diagnostic_setting" "application_gateway" {
#   name                       = "Application Gateway Logs"
#   target_resource_id         = azurerm_kubernetes_cluster.default.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   enabled_log {
#     category = "kube-apiserver"
#   }

#   enabled_log {
#     category = "kube-audit"
#   }

#   enabled_log {
#     category = "kube-audit-admin"
#   }

#   enabled_log {
#     category = "kube-controller-manager"
#   }

#   enabled_log {
#     category = "kube-scheduler"
#   }

#   enabled_log {
#     category = "cluster-autoscaler"
#   }

#   enabled_log {
#     category = "guard"
#   }

#   metric {
#     category = "AllMetrics"
#   }
# }

data "azurerm_public_ip" "default" {
  name                = "agw-${var.root_name}-appgwpip"
  resource_group_name = azurerm_kubernetes_cluster.default.node_resource_group

  depends_on = [
    azurerm_kubernetes_cluster.default
  ]
}
