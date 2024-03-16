variable "app_root" {
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


variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "nsg_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
