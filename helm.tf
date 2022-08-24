resource "helm_release" "nginx" {
  name       = "tfm-ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.2.1"

  namespace        = var.ingress_nginx_namespace
  create_namespace = true
  atomic           = true
  cleanup_on_fail  = true
}

resource "helm_release" "external-dns" {
  name       = "tfm-external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.11.0"

  values = [
    "${file("chart_values/external-dns-values.yaml")}"
  ]

  namespace        = var.external_dns_namespace
  create_namespace = true
  atomic           = true
  cleanup_on_fail  = true

  depends_on = [
    kubernetes_secret.external_dns_secret
  ]
}

resource "helm_release" "argocd" {
  name       = "tfm-argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.10.8"

  namespace        = var.argocd_namespace
  create_namespace = true
  atomic           = true
  cleanup_on_fail  = true

  values = [
    "${file("chart_values/argocd-values.yaml")}"
  ]

  depends_on = [
    helm_release.nginx,
    helm_release.external-dns,
    module.cert-manager
  ]
}