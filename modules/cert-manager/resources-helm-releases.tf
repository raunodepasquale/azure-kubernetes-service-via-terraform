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

resource "helm_release" "issuers" {
  name  = "issuers"
  chart = "issuers"
  repository = "./modules/cert-manager"
  namespace = "cert-manager"
  version = "0.1.0"

  set {
    name  = "email.production"
    value = var.emailproduction
  }
  set {
    name  = "email.staging"
    value = var.emailstaging
  }
  depends_on = [
    helm_release.cert-manager
  ]
}
