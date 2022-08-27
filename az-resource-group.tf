resource "azurerm_resource_group" "jruedas_rsg" {
  name     = var.resource_group
  location = var.location

  tags = var.tags
}