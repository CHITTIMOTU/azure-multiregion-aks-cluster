terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.95.0"
    }
  }
  backend "local" {
    path = "./.workspace/terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

locals {
  main_tags     = { Instance = "Main" }
  failover_tags = { Instance = "Failover" }
}


module "network_main" {
  source              = "../azure/network"
  location            = var.main_location
  vnet_cidr           = var.main_cidr
  aks_address         = var.main_aks_address
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
  aks_address         = var.failover_aks_address
  gateway_address     = var.failover_gateway_address
  jumpbox_address     = var.failover_jumpbox_address
  Bastion_address     = var.failover_Bastion_address
  environment         = var.environment
  instance            = var.failover_instance
  jumbbox_vm_password = var.jumbbox_vm_password
  tags                = local.failover_tags
}
