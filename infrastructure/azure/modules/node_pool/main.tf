resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  kubernetes_cluster_id        = var.kubernetes_cluster_id
  name                         = var.name
  vm_size                      = var.vm_size
  mode                         = var.mode
  node_labels                  = var.node_labels
  node_taints                  = var.node_taints
  zones                        = var.availability_zones
  vnet_subnet_id               = var.vnet_subnet_id
  pod_subnet_id                = var.pod_subnet_id
  enable_auto_scaling          = var.enable_auto_scaling
  enable_host_encryption       = var.enable_host_encryption
  enable_node_public_ip        = var.enable_node_public_ip
  proximity_placement_group_id = var.proximity_placement_group_id
  orchestrator_version         = var.orchestrator_version
  max_pods                     = var.max_pods
  max_count                    = var.max_count
  min_count                    = var.min_count
  node_count                   = var.node_count
  os_disk_size_gb              = var.os_disk_size_gb
  os_disk_type                 = var.os_disk_type
  os_type                      = var.os_type
  priority                     = var.priority
  tags                         = var.tags

  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}

# az aks nodepool add -g rg-mahb-prod-001 -n nodepool1 --cluster-name aks-mahb-prod-001 --os-sku Ubuntu --pod-subnet-id /subscriptions/524875d7-62d5-42df-8fe5-78822e211bf3/resourceGroups/rg-network-prod-001/providers/Microsoft.Network/virtualNetworks/vnet-network-prod-001/subnets/aks-PodSubnet 


# --vnet-subnet-id /subscriptions/524875d7-62d5-42df-8fe5-78822e211bf3/resourceGroups/rg-network-prod-001/providers/Microsoft.Network/virtualNetworks/vnet-network-prod-001/subnets/aks-UserSubnet