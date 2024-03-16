output "agw_public_ip_address" {
  value = data.azurerm_public_ip.default.ip_address
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.default.identity[0].principal_id
}

output "name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.default.fqdn
}

output "oidc_issuer_url" {
  value = azurerm_kubernetes_cluster.default.oidc_issuer_url
}

# output "aks_identity_principal_id" {
#   value       = azurerm_user_assigned_identity.aks_identity.principal_id
#   description = "Specifies the principal id of the managed identity of the AKS cluster."
# }
