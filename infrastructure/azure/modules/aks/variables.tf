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

########################

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.2.0.10"
  type        = string
}

variable "network_service_cidr" {
  description = "Specifies the service CIDR"
  default     = "10.2.0.0/24"
  type        = string
}

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}

variable "outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  type        = string
  default     = "userDefinedRouting"

  validation {
    condition = contains(["loadBalancer", "userDefinedRouting", "userAssignedNATGateway", "managedNATGateway"], var.outbound_type)
    error_message = "The outbound type is invalid."
  }
}

variable "keda_enabled" {
  description = "(Optional) Specifies whether KEDA Autoscaler can be used for workloads."
  type        = bool
  default     = true
}

variable "vertical_pod_autoscaler_enabled" {
  description = "(Optional) Specifies whether Vertical Pod Autoscaler should be enabled."
  type        = bool
  default     = true
}

variable "dns_zone_name" {
  description = "Specifies the name of the DNS zone."
  type = string
  default = null
}

variable "dns_zone_resource_group_name" {
  description = "Specifies the name of the resource group that contains the DNS zone."
  type = string
  default = null
}

variable "aks_private_dns_zone_id" {
  description = "(Optional) Should Web App Routing be enabled?"
  type        = string
}

variable "web_app_routing" {
  description   = "Specifies the Application HTTP Routing addon configuration."
  type          = object({
    enabled     = bool
    dns_zone_id = string
  })
  default       = {
    enabled     = false           
    dns_zone_id = null
  }
}