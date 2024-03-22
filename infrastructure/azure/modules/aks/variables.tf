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

variable "gateway_subnet_id" {
  type = string
}



variable "aks_ApiServer_id" {
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

variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = ["bc7ffd30-a56a-4efe-995d-231163f2128b"]
  type        = list(string)
}

variable "private_dns_zone_id" {
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

variable "pod_subnet_id" {
  description = "(Optional) The ID of the Subnet where the pods in the system node pool should exist. Changing this forces a new resource to be created."
  type          = string
  default       = null
}

variable "system_node_pool_name" {
  description = "Specifies the name of the system node pool"
  default     =  "system"
  type        = string
}



variable "system_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type          = bool
  default       = true
}

variable "system_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type          = bool
  default       = false
} 

variable "system_node_pool_enable_node_public_ip" {
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
  type          = bool
  default       = false
} 

variable "system_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type          = number
  default       = 30
}

variable "system_node_pool_node_labels" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type          = map(any)
  default       = {}
} 

variable "system_node_pool_node_taints" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
  type          = list(string)
  default       = []
} 

variable "system_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type          = string
  default       = "Ephemeral"
} 

variable "system_node_pool_max_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type          = number
  default       = 1
}

variable "system_node_pool_min_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type          = number
  default       = 1
}

variable "system_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type          = number
  default       = 1
}

variable "system_node_pool_vm_size" {
  description = "Specifies the vm size of the system node pool"
  default     = "Standard_F8s_v2"
  type        = string
}

variable "system_node_pool_availability_zones" {
  description = "Specifies the availability zones of the system node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
}


variable "vnet_subnet_id" {
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "orchestrator_version" {
  description = "(Optional) Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)"
  type          = string
} 

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  type        = string
}