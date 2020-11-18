resource "helm_release" "ingress-nginx" {
  name  = "ingress-nginx"
  chart = "ingress-nginx"
  repository = "https://kubernetes.github.io"
  version = "v3.10.1"

  set {
    namespace  = var.namespace
  }
  depends_on = [
    null_resource.delay,
    kubernetes_namespace.ingress
  ]
}

