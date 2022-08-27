data "azurerm_subscription" "jruedas_as" {}

resource "azurerm_dns_zone" "jruedas_dns_zone" {
  name                = var.my_domain_name
  resource_group_name = azurerm_resource_group.jruedas_rsg.name
  tags                = var.tags
}

resource "local_file" "nameservers_file" {
  filename = var.nameservers_name
  content  = join("\n", azurerm_dns_zone.jruedas_dns_zone.name_servers)
}

resource "azurerm_role_assignment" "jruedas_dns_ra" {
  principal_id         = azurerm_kubernetes_cluster.jruedas_aks.kubelet_identity[0].object_id
  scope                = azurerm_dns_zone.jruedas_dns_zone.id
  role_definition_name = "DNS Zone Contributor"
}