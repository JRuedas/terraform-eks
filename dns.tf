resource "azurerm_dns_zone" "jruedas_zone" {
  name                = var.my_domain_name
  resource_group_name = azurerm_resource_group.az_rsg.name
  tags                = var.tags
}

resource "local_file" "nameservers_file" {
  filename = "nameservers.txt"
  content  = join(",", azurerm_dns_zone.jruedas_zone.name_servers)
}

resource "azurerm_role_assignment" "jruedas-ra" {
  principal_id         = azurerm_kubernetes_cluster.jruedas-aks.kubelet_identity[0].object_id
  scope                = azurerm_dns_zone.jruedas_zone.id
  role_definition_name = "Reader"
}