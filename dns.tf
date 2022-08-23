resource "azurerm_dns_zone" "jruedas_zone" {
  name                = var.my_domain_name
  resource_group_name = azurerm_resource_group.az_rsg.name
  tags                = var.tags
}

resource "local_file" "nameservers_file" {
  filename = "nameservers.txt"
  content  = join("\n", azurerm_dns_zone.jruedas_zone.name_servers)
}

resource "azurerm_role_assignment" "jruedas-dns-ra" {
  principal_id         = azurerm_kubernetes_cluster.jruedas-aks.kubelet_identity[0].object_id
  scope                = azurerm_dns_zone.jruedas_zone.id
  role_definition_name = "DNS Zone Contributor"
}

data "azurerm_subscription" "current" {}

resource "kubernetes_secret" "external_dns_secret" {
  metadata {
    name      = "azure-config-file"
    namespace = "external-dns"
  }

  data = {
    "azure.json" = jsonencode({
      "tenantId"                    = "${data.azurerm_subscription.current.tenant_id}",
      "subscriptionId"              = "${data.azurerm_subscription.current.subscription_id}",
      "resourceGroup"               = "${azurerm_resource_group.az_rsg.name}",
      "useManagedIdentityExtension" = true
    })
  }
}