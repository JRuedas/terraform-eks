resource "helm_release" "argocd" {
  name       = "argocd"
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
}