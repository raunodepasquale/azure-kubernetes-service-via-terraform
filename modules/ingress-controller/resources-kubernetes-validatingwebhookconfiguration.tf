resource "kubernetes_validating_webhook_configuration" "ingress" {
  metadata {
    name = "ingress-nginx-admission"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
  }

  webhook {
    name = "validate.nginx.ingress.kubernetes.io"

    admission_review_versions = ["v1", "v1beta1"]

    client_config {
      service {
        namespace = var.namespace
        name = "ingress-nginx-controller-admission"
        path = "/extensions/v1beta1/ingresses"
      }
    }

    rule {
      api_groups = ["extensions","networking.k8s.io"]
      api_versions = ["v1beta1"]
      operations = ["CREATE","UPDATE"]
      resources = ["ingresses"]
    }
    failure_policy = "Fail"
    side_effects = "None"
  }
}