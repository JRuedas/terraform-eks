resource "azurerm_kubernetes_cluster" "jruedas_aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.jruedas_rsg.location
  resource_group_name = azurerm_resource_group.jruedas_rsg.name
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

  tags = var.tags
}

resource "local_file" "jruedas_kubeconfig" {
  filename        = pathexpand("~/.kube/${var.kubeconfig_name}.kubeconfig")
  file_permission = "600"
  content         = azurerm_kubernetes_cluster.jruedas_aks.kube_config_raw
}