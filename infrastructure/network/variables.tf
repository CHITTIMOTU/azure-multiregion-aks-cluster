### General
variable "application_name" {
  type        = string
  description = "The application name is used for composition of all the resouces in the solution."
  default     = "mahb"

  validation {
    condition     = can(regex("^[[:alnum:]]+$", var.application_name))
    error_message = "Application name must be composed by integers and lower-case letters only."
  }
}

variable "main_location" {
  type        = string
  description = "The location of the Main site."
  default     = "southeastasia"
}

variable "failover_location" {
  type        = string
  description = "The location of the Failover site."
  default     = "eastasia"
}

variable "environment" {
  type        = string
  description = "The keyword to identify te type of Environment that it's being deployed."
  default     = "prod"
}

variable "main_instance" {
  type        = string
  description = "Instance code to be added to Main resources."
  default     = "001"
}

variable "main_cidr" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.56.0/21"]
}

variable "main_Bastion_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.56.0/27"]
}
variable "main_jumpbox_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.56.32/27"]
}
variable "main_gateway_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.56.64/27"]
}
variable "main_ApiServer_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.56.96/27"]
}
variable "main_SystemSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.57.0/24"]
}
variable "main_UserSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.58.0/24"]
}
variable "main_PodSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.60.0/22"]
}

variable "failover_instance" {
  type        = string
  description = "Instance code to be added to Failover resources."
  default     = "002"
}

variable "failover_cidr" {
  type        = list
  description = "CIDR address space for failover V-net"
  default     = ["10.140.56.0/21"]
}

variable "failover_Bastion_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.56.0/27"]
}
variable "failover_jumpbox_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.56.32/27"]
}
variable "failover_gateway_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.56.64/27"]
}
variable "failover_ApiServer_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.56.96/27"]
}
variable "failover_SystemSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.57.0/24"]
}
variable "failover_UserSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.58.0/24"]
}
variable "failover_PodSubnet_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.60.0/22"]
}

variable "jumbbox_vm_password" {
  type        = string
  description = "The password to connect to the Jumpbox VM"
  default     = "P@ssw0rd.123"
  sensitive   = true
}

variable "storage_account_kind" {
  description = "(Optional) Specifies the account kind of the storage account"
  default     = "StorageV2"
  type        = string

   validation {
    condition = contains(["Storage", "StorageV2"], var.storage_account_kind)
    error_message = "The account kind of the storage account is invalid."
  }
}

variable "storage_account_tier" {
  description = "(Optional) Specifies the account tier of the storage account"
  default     = "Standard"
  type        = string

   validation {
    condition = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "The account tier of the storage account is invalid."
  }
}

variable "storage_account_replication_type" {
  description = "(Optional) Specifies the replication type of the storage account"
  default     = "LRS"
  type        = string

  validation {
    condition = contains(["LRS", "ZRS", "GRS", "GZRS", "RA-GRS", "RA-GZRS"], var.storage_account_replication_type)
    error_message = "The replication type of the storage account is invalid."
  }
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default     = {
    createdWith = "Terraform"
  }
}