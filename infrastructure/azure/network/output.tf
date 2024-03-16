# output "bastion_subnet_id" {
#   value = module.bastion.id
# }

# output "jumpbox_subnet_id" {
#   value = module.vnet.jumpbox_subnet_id
# }

output "gateway_subnet_id" {
  value = module.vnet.gateway_subnet_id
}

# output "aks_PodSubnet_id" {
#   value = module.vnet.aks_PodSubnet_subnet_id
# }
