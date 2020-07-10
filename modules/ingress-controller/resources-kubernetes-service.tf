resource "kubernetes_service" "webhook" {
  metadata {
    name = "ingress-nginx-controller-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
  spec {
    selector = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    port {
      name        = "https-webhook"  
      port        = 443
      target_port = "webhook"
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_service" "ingress" {
  metadata {
    name = "ingress-nginx-controller"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
    annotations = {
        "service.beta.kubernetes.io/azure-load-balancer-resource-group" = azurerm_resource_group.ingress.name
        "service.beta.kubernetes.io/azure-dns-label-name" = "ingress-${var.prefix}-${var.env}-${var.locationcode}"
    }
  }
  spec {
    selector = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    port {
      name        = "http" 
      protocol    = "TCP" 
      port        = 80
      target_port = "http"
    }
    port {
      name        = "https" 
      protocol    = "TCP" 
      port        = 443
      target_port = "https"
    }
    type = "LoadBalancer"
    load_balancer_ip  = azurerm_public_ip.ingress.ip_address
  }
}