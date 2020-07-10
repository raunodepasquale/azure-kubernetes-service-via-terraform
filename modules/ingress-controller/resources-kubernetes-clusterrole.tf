resource "kubernetes_cluster_role" "ingress" {
  metadata {
    name = "ingress-nginx"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["configmaps","endpoints","nodes","pods","secrets"]
    verbs      = ["list", "watch"]
  }
  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get"]
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
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create","patch"]
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
}

resource "kubernetes_cluster_role" "admission" {
  metadata {
    name = "ingress-nginx-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources  = ["validatingwebhookconfigurations"]
    verbs      = ["get", "update"]
  }
}

