resource "azurerm_dns_zone" "example-public" {
  name                = var.my_domain_name
  resource_group_name = azurerm_resource_group.az_rsg.name
  tags                = var.tags
}