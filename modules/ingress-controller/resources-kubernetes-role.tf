resource "kubernetes_role" "ingress" {
  metadata {
    name = "ingress-nginx"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get"]
  }
  rule {
    api_groups = [""]
    resources  = ["configmaps","pods","secrets","endpoints"]
    verbs      = ["get","list","watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get","list","update","watch"]
  }
  rule {
    api_groups = ["extensions","networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get","list","watch"]
  }
  rule {
    api_groups = ["extensions","networking.k8s.io"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingressclasses"]
    verbs      = ["get","list","watch"]
  }
rule {
    api_groups = [""]
    resources  = ["configmaps"]
    verbs      = ["get","update","create"]
  }
rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs      = ["get","update","create"]
  }
rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["patch","create"]
  }
}

resource "kubernetes_role" "admission" {
  metadata {
    name = "ingress-nginx-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get","create"]
  }
}