# Used to provision the whole azure resources (AKS, DNS zone, etc)
provider "azurerm" {
  # Configuration options. Not required, login using CLI.
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

# Used to create the secret with azure credentials to make external-dns work
provider "kubernetes" {
  # HACK: required to instruct terraform to wait until the kubeconfig is properly placed
  config_path    = local_file.jruedas_kubeconfig.filename
  config_context = var.cluster_name
}

# Used to install the helm charts (Nginx, External-DNS and ArgoCD) in the cluster
provider "helm" {

  kubernetes {
    # HACK: required to instruct terraform to wait until the kubeconfig is properly placed
    config_path = local_file.jruedas_kubeconfig.filename
  }
}

provider "kubectl" {
  # HACK: required to instruct terraform to wait until the kubeconfig is properly placed
  config_path    = local_file.jruedas_kubeconfig.filename
  config_context = var.cluster_name
}