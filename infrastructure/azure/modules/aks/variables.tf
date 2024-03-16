variable "root_name" {
  type = string
}

variable "vnetrg" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "default_namespace" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}

variable "vm_size" {
  type = string
}

variable "aks_System_id" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}

variable "aks_Pod_id" {
  type = string
}

variable "aks_ApiServer_id" {
  type = string
}
variable "aks_User_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

