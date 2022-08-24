module "cert-manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"
  version       = "2.4.2"
  chart_version = "v1.9.1"

  namespace_name   = var.cert_manager_namespace
  create_namespace = true

  additional_set = [{
    name  = "installCRDs"
    value = "true"
  }]

  cluster_issuer_name                    = "letsencrypt-prod"
  cluster_issuer_server                  = "https://acme-v02.api.letsencrypt.org/directory"
  cluster_issuer_email                   = var.my_mail
  cluster_issuer_private_key_secret_name = "letsencrypt-prod"

  solvers = [{
    dns01 = {
      azureDNS = {
        environment       = "AzurePublicCloud"
        hostedZoneName    = var.my_domain_name
        resourceGroupName = azurerm_resource_group.az_rsg.name
        subscriptionID    = data.azurerm_subscription.current.subscription_id
        managedIdentity = {
          clientID = azurerm_kubernetes_cluster.jruedas-aks.kubelet_identity[0].client_id
        }
      }
    }
  }]
}