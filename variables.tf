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

variable "kubeconfig_name" {
  description = "AKS Kubeconfig name."
  type        = string
  default     = "aks-tfm"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Owner       = "JRuedas"
    Environment = "TFM"
    ManagedBy   = "Terraform"
  }
}

# DNS
variable "my_domain_name" {
  description = "My domain name."
  type        = string
  default     = "jruedas.dev"
}

# Cert manager
variable "nameservers_name" {
  description = "File with AZ nameservers."
  type        = string
  default     = "nameservers.txt"
}

variable "my_mail" {
  description = "My domain name."
  type        = string
  default     = "jonatan.ruedas050@comunidadunir.net"
}

# Helm charts

variable "ingress_nginx_namespace" {
  description = "Namespace for ingress Nginx components."
  type        = string
  default     = "ingress-nginx"
}

variable "external_dns_namespace" {
  description = "Namespace for external dns components."
  type        = string
  default     = "external-dns"
}

variable "cert_manager_namespace" {
  description = "Namespace for cert manager components."
  type        = string
  default     = "cert-manager"
}

variable "argocd_namespace" {
  description = "Namespace for argocd components."
  type        = string
  default     = "argocd"
}