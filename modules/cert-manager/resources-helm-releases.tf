resource "helm_release" "cert-manager" {
  name  = "cert-manager"
  chart = "cert-manager"
  repository = "https://charts.jetstack.io"
  namespace = "cert-manager"
  version = "v0.15.2"

  set {
    name  = "installCRDs"
    value = "true"
  }
  depends_on = [
    null_resource.delay,
    kubernetes_namespace.cert-manager
  ]
}


