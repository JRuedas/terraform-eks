resource "helm_release" "nginx" {
  name       = "tfm-ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "nginx/ingress-nginx"
  version    = "4.2.1"

  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "argocd" {
  name       = "tfm-argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd/argo-cd"
  version    = "4.10.8"

  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("argocd-init.yaml")}"
  ]

  depends_on = [
    helm_release.nginx
  ]
}