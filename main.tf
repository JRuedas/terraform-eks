terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.19.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }

  required_version = "1.2.7"
}