resource "kubernetes_namespace" "ingress" {
  metadata {
    annotations = {
      name = var.namespace
    }

    labels = {
      "app.kubernetes.io/name" = var.namespace
      "app.kubernetes.io/instance" = var.namespace
    }

    name = var.namespace
  }
}