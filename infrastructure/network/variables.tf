### General

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
  default     = ["10.120.52.0/22"]
}

variable "main_Bastion_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.52.0/25"]
}
variable "main_jumpbox_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.52.128/25"]
}
variable "main_gateway_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.53.0/24"]
}
variable "main_aks_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.120.54.0/23"]
}

variable "failover_instance" {
  type        = string
  description = "Instance code to be added to Failover resources."
  default     = "002"
}

variable "failover_cidr" {
  type        = list
  description = "CIDR address space for failover V-net"
  default     = ["10.140.52.0/22"]
}

variable "failover_Bastion_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.52.0/25"]
}
variable "failover_jumpbox_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.52.128/25"]
}
variable "failover_gateway_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.53.0/24"]
}
variable "failover_aks_address" {
  type        = list
  description = "Subnet address space for main V-net"
  default     = ["10.140.54.0/23"]
}

variable "jumbbox_vm_password" {
  type        = string
  description = "The password to connect to the Jumpbox VM"
  default     = "P@ssw0rd.123"
  sensitive   = true
}
