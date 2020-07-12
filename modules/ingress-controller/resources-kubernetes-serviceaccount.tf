resource "kubernetes_service_account" "ingress" {
  metadata {
    name = "ingress-nginx"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
depends_on = [
    kubernetes_namespace.ingress
]
}

resource "kubernetes_service_account" "admission" {
  metadata {
    name = "ingress-nginx-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
depends_on = [
    kubernetes_namespace.ingress
]
}