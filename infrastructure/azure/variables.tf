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

variable "failover_instance" {
  type        = string
  description = "Instance code to be added to Failover resources."
  default     = "002"
}

# variable "main_dns_zone_name" {
#   description = "Specifies the name of the DNS zone."
#   type = string
#   default = "private.southeastasia.azmk8s.io"
# }

# variable "main_dns_zone_resource_group_name" {
#   description = "Specifies the name of the resource group that contains the DNS zone."
#   type = string
#   default = "mahb-dns"
# }

# variable "failover_dns_zone_name" {
#   description = "Specifies the name of the DNS zone."
#   type = string
#   default = "private.eastasia.azmk8s.io"
# }

variable "main_aks_private_dns_zone_id" {
  description = "Specifies the name of the DNS zone."
  type = string
  default = "/subscriptions/2c22ccdb-ba3a-45b0-b2f7-70cc02a39b0a/resourceGroups/MAHB-DNS/providers/Microsoft.Network/privateDnsZones/private.southeastasia.azmk8s.io"
}
variable "failover_aks_private_dns_zone_id" {
  description = "Specifies the name of the DNS zone."
  type = string
  default = "/subscriptions/2c22ccdb-ba3a-45b0-b2f7-70cc02a39b0a/resourceGroups/MAHB-DNS-eastasia/providers/Microsoft.Network/privateDnsZones/private.eastasia.azmk8s.io"
}

# variable "failover_dns_zone_resource_group_name" {
#   description = "Specifies the name of the resource group that contains the DNS zone."
#   type = string
#   default = "mahb-dns-eastasia"
# }

### AKS

variable "aks_vm_size" {
  description = "Kubernetes VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "aks_node_count" {
  type    = number
  default = 1
}
