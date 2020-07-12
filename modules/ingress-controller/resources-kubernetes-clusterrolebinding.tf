resource "kubernetes_cluster_role_binding" "ingress" {
  metadata {
    name = "ingress-nginx"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.ingress.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ingress.metadata[0].name
    namespace = var.namespace
  }
  depends_on = [
    kubernetes_namespace.ingress,
    kubernetes_cluster_role.ingress,
    kubernetes_service_account.ingress
]
}

resource "kubernetes_cluster_role_binding" "admission" {
  metadata {
    name = "ingress-nginx-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.admission.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.admission.metadata[0].name
    namespace = var.namespace
  }
  depends_on = [
    kubernetes_namespace.ingress,
    kubernetes_cluster_role.admission,
    kubernetes_service_account.admission
]
}