resource "azurerm_kubernetes_cluster" "jruedas-aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.az_rsg.location
  resource_group_name = azurerm_resource_group.az_rsg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = var.cluster_size
    vm_size    = var.instance_type
  }

  kubernetes_version = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Author      = "Jonatan Ruedas"
    Environment = "TFM"
    ManagedBy   = "Terraform"
  }
}

resource "local_file" "kubeconfig" {
  filename        = "~/.kube/${var.kubeconfig_name}.kubeconfig"
  file_permission = "600"
  content         = azurerm_kubernetes_cluster.jruedas-aks.kube_config_raw
}