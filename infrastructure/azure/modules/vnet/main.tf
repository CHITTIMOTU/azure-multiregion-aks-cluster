resource "azurerm_virtual_network" "default" {
  name                = "vnet-${var.app_root}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_cidr

  tags = var.tags
}

resource "azurerm_subnet" "bastion" {
name                 = "AzureBastionSubnet"
resource_group_name  = var.resource_group_name
virtual_network_name = azurerm_virtual_network.default.name
address_prefixes     = var.Bastion_address
}

resource "azurerm_subnet_network_security_group_association" "subnet-bastion" {
subnet_id                 = azurerm_subnet.bastion.id
network_security_group_id = var.nsg_id
}

resource "azurerm_subnet" "jumpbox" {
name                 = "subnet-jumpbox"
resource_group_name  = var.resource_group_name
virtual_network_name = azurerm_virtual_network.default.name
address_prefixes     = var.jumpbox_address
service_endpoints    = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]
}


# Workload Resouces

resource "azurerm_subnet" "voteapp_gateway" {
name                 = "subnet-gateway"
resource_group_name  = var.resource_group_name
virtual_network_name = azurerm_virtual_network.default.name
address_prefixes     = var.gateway_address
}



resource "azurerm_subnet" "aks_SystemSubnet" {
  name                  = "aks-SystemSubnet"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.default.name
  address_prefixes      = var.SystemSubnet_address
  service_endpoints     = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]
}


resource "azurerm_subnet" "aks_UserSubnet" {
  name                  = "aks-UserSubnet"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.default.name
  address_prefixes      = var.UserSubnet_address
  service_endpoints     = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]
}

resource "azurerm_subnet" "aks_PodSubnet" {
  name                  = "aks-PodSubnet"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.default.name
  address_prefixes      = var.PodSubnet_address
  service_endpoints     = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]
}

resource "azurerm_subnet" "aks_ApiServer" {
  name                  = "aks-ApiServer"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = azurerm_virtual_network.default.name
  address_prefixes      = var.ApiServer_address
  service_endpoints     = ["Microsoft.AzureCosmosDB", "Microsoft.KeyVault"]
}