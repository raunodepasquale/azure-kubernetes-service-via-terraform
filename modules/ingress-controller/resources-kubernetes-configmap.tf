resource "kubernetes_config_map" "ingress" {
  metadata {
    name = "ingress-nginx-controller"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
  data = {}    
}