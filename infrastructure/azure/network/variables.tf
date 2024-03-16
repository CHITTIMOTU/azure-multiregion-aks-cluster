variable "location" {
  type = string
}

variable "vnet_cidr" {
  type = list
}

variable "Bastion_address" {
  type = list
}

variable "jumpbox_address" {
  type = list
}

variable "gateway_address" {
  type = list
}

variable "SystemSubnet_address" {
  type = list
}

variable "UserSubnet_address" {
  type = list
}

variable "PodSubnet_address" {
  type = list
}

variable "ApiServer_address" {
  type = list
}

variable "environment" {
  type = string
}

variable "instance" {
  type = string
}

variable "jumbbox_vm_password" {
  type = string
  sensitive = true
}

variable "tags" {
  type = map(string)
}
