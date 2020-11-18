resource "helm_release" "ingress-nginx" {
  name  = "ingress-nginx"
  chart = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version = "v3.10.1"

  set {
    name  = "namespace"
    value = var.namespace
  }

  set {
    name  = "controller.service.loadBalancerIP "
    value = azurerm_public_ip.ingress.ip_address
  }

  depends_on = [
    null_resource.delay,
    kubernetes_namespace.ingress
  ]
}

