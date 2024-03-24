terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
  # backend "local" {
  #   path = "./.workspace/terraform.tfstate"
  # }
  backend "azurerm" {
    resource_group_name  = "rg-terraform-prodmahb"
    storage_account_name = "stgprodmahb"
    container_name       = "tfstate-donot-modify-delete"
    key                  = "network.prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

locals {
  main_tags     = { Instance = "Main" }
  failover_tags = { Instance = "Failover" }
  root_name = "${var.environment}${var.application_name}"
}

module "rg_terraform" {
  source    = "../azure/modules/group"
  root_name = "terraform-${local.root_name}"
  location  = var.main_location
  tags      = var.tags
}

module "network_main" {
  source              = "../azure/network"
  location            = var.main_location
  vnet_cidr           = var.main_cidr
  SystemSubnet_address   = var.main_SystemSubnet_address
  UserSubnet_address     = var.main_UserSubnet_address
  PodSubnet_address      = var.main_PodSubnet_address
  ApiServer_address      = var.main_ApiServer_address
  gateway_address     = var.main_gateway_address
  jumpbox_address     = var.main_jumpbox_address
  Bastion_address     = var.main_Bastion_address
  environment         = var.environment
  instance            = var.main_instance
  jumbbox_vm_password = var.jumbbox_vm_password
  tags                = local.main_tags
}

module "network_failover" {
  source              = "../azure/network"
  location            = var.failover_location
  vnet_cidr           = var.failover_cidr
  SystemSubnet_address = var.failover_SystemSubnet_address
  UserSubnet_address     = var.failover_UserSubnet_address
  PodSubnet_address      = var.failover_PodSubnet_address
  ApiServer_address      = var.failover_ApiServer_address
  gateway_address     = var.failover_gateway_address
  jumpbox_address     = var.failover_jumpbox_address
  Bastion_address     = var.failover_Bastion_address
  environment         = var.environment
  instance            = var.failover_instance
  jumbbox_vm_password = var.jumbbox_vm_password
  tags                = local.failover_tags
}


module "storage_account" {
source                      = "../azure/modules/storage_account"
name                        = "stg${local.root_name}"
location                    = var.main_location
resource_group_name         = module.rg_terraform.name
account_kind                = var.storage_account_kind
account_tier                = var.storage_account_tier
replication_type            = var.storage_account_replication_type
tags                        = var.tags

}