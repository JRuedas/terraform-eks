resource "azurerm_resource_group" "az_rsg" {
  name     = var.resource_group
  location = var.location

  tags = var.tags
}