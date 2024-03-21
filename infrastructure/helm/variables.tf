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

# variable "host" {
#   description = "The host in the azurerm_kubernetes_cluster's kube_admin_config block. The Kubernetes cluster server host."
#   type = string
# }

variable "username" {
  description = "The username in the azurerm_kubernetes_cluster's kube_admin_config block. A username used to authenticate to the Kubernetes cluster."
  type = string
}

variable "password" {
  description = "The password in the azurerm_kubernetes_cluster's kube_admin_config block. A password or token used to authenticate to the Kubernetes cluster."
  sensitive = true
  type = string
}

# variable "client_certificate" {
#   description = "The client_certificate in the azurerm_kubernetes_cluster's kube_admin_config block.  Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
#   sensitive = true
#   type = string
# }

# variable "client_key" {
#   description = "The client_key in the azurerm_kubernetes_cluster's kube_admin_config block. Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
#   sensitive = true
#   type = string
# }

# variable "cluster_ca_certificate" {
#   description = "The cluster_ca_certificate in the azurerm_kubernetes_cluster's kube_admin_config block. Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
#   sensitive = true
#   type = string
# }
