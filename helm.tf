resource "helm_release" "nginx" {
  name       = "tfm-ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.2.1"

  namespace        = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "external-dns" {
  name       = "tfm-external-dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"
  version    = "1.11.0"

  values = [
    "${file("external-dns-values.yaml")}"
  ]

  namespace        = "external-dns"
  create_namespace = true

  depends_on = [
    helm_release.nginx
  ]
}

resource "helm_release" "argocd" {
  name       = "tfm-argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.10.8"

  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("argocd-values.yaml")}"
  ]

  depends_on = [
    helm_release.nginx
  ]
}