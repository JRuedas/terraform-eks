provider "azurerm" {
  # Configuration options. Not required, login using CLI.
  features {}
}

provider "helm" {

  kubernetes {
    # HACK: required to instruct terraform to wait until the kubeconfig is properly placed
    config_path = local_file.kubeconfig.filename
  }
}