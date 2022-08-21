# AZ Resource Group
variable "resource_group" {
  description = "AZ resource group."
  type        = string
  default     = "tfm-jruedas-rg"
}

variable "location" {
  description = "AZ resource group."
  type        = string
  default     = "East US"
}

# AKS
variable "cluster_name" {
  description = "AKS cluster name."
  type        = string
  default     = "tfm-jruedas-aks"
}

variable "node_pool_name" {
  description = "AKS node pool name."
  type        = string
  default     = "tfmjruedasnp"
}

variable "cluster_size" {
  description = "AKS cluster size."
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "AKS instance types."
  type        = string
  default     = "Standard_B2s"
}

variable "dns_prefix" {
  description = "AKS DNS prefix."
  type        = string
  default     = "tmf-jruedas"
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version."
  type        = string
  default     = "1.22"
}