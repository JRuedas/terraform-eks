data "azurerm_client_config" "jruedas_cc" {}

resource "azurerm_key_vault" "jruedas_kv" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.jruedas_rsg.location
  resource_group_name = azurerm_resource_group.jruedas_rsg.name

  tenant_id = data.azurerm_subscription.jruedas_as.tenant_id
  sku_name  = "standard"
}

resource "azurerm_key_vault_access_policy" "jruedas_admin_kvp" {
  key_vault_id = azurerm_key_vault.jruedas_kv.id
  tenant_id    = data.azurerm_subscription.jruedas_as.tenant_id
  object_id    = data.azurerm_client_config.jruedas_cc.object_id

  key_permissions         = var.key_vault_admin_key_permissions
  secret_permissions      = var.key_vault_admin_secret_permissions
  certificate_permissions = var.key_vault_admin_certificate_permissions
  storage_permissions     = var.key_vault_admin_storage_permissions

  depends_on = [
    azurerm_key_vault.jruedas_kv
  ]
}

resource "azurerm_key_vault_access_policy" "jruedas_aks_kvp" {
  key_vault_id = azurerm_key_vault.jruedas_kv.id
  tenant_id    = data.azurerm_subscription.jruedas_as.tenant_id
  object_id    = azurerm_kubernetes_cluster.jruedas_aks.kubelet_identity[0].object_id

  key_permissions    = ["Get"]
  secret_permissions = ["Get"]

  depends_on = [
    azurerm_key_vault.jruedas_kv,
    azurerm_key_vault_access_policy.jruedas_admin_kvp
  ]
}

resource "azurerm_key_vault_secret" "external_dns_secret" {
  name         = var.external_dns_secret_name
  key_vault_id = azurerm_key_vault.jruedas_kv.id

  value = jsonencode({
    "tenantId"                    = "${data.azurerm_subscription.jruedas_as.tenant_id}",
    "subscriptionId"              = "${data.azurerm_subscription.jruedas_as.subscription_id}",
    "resourceGroup"               = "${azurerm_resource_group.jruedas_rsg.name}",
    "useManagedIdentityExtension" = true
  })

  depends_on = [
    azurerm_key_vault.jruedas_kv,
    azurerm_key_vault_access_policy.jruedas_admin_kvp,
    azurerm_key_vault_access_policy.jruedas_aks_kvp
  ]
}

resource "azurerm_key_vault_secret" "cert_manager_secret" {
  name         = var.cert_manager_secret_name
  key_vault_id = azurerm_key_vault.jruedas_kv.id

  value = jsonencode({
    "subscriptionId" = "${data.azurerm_subscription.jruedas_as.subscription_id}",
    "clientId"       = "${data.azurerm_client_config.jruedas_cc.client_id}"
  })

  depends_on = [
    azurerm_key_vault.jruedas_kv,
    azurerm_key_vault_access_policy.jruedas_admin_kvp,
    azurerm_key_vault_access_policy.jruedas_aks_kvp
  ]
}