resource "kubernetes_deployment" "ingress" {
  metadata {
    name = "ingress-nginx-controller"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }

  spec {
    revision_history_limit = 10
    min_ready_seconds = 0  
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
      }
    }

    template {
      metadata {
        labels = {
            "app.kubernetes.io/name" = "ingress-nginx"
            "app.kubernetes.io/instance" = "ingress-nginx"
            "app.kubernetes.io/component" = "controller"
        }
      }

      spec {
        dns_policy = "ClusterFirst"
        service_account_name = "ingress-nginx"
        termination_grace_period_seconds = 300
        volume {
            name = "webhook-cert"
            secret {
                secret_name = "ingress-nginx-admission"
            }
        }
        container {
          image = "quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.33.0"
          name  = "controller"
          image_pull_policy = "IfNotPresent"
          env {
              name = "POD_NAME"
              value = "ingress-nginx-controller"
          }
          env {
              name = "POD_NAMESPACE"
              value = var.namespace
          }
          port {
              name = "http"
              container_port = 80
              protocol = "TCP"
          }
          port {
              name = "https"
              container_port = 443
              protocol = "TCP"
          }
          port {
              name = "webhook"
              container_port = 8443
              protocol = "TCP"
          }
          volume_mount {
            name       = "webhook-cert"
            mount_path = "/usr/local/certificates/"
            read_only = true
          }
          lifecycle {
              pre_stop {
                  exec {
                    command = ["- /wait-shutdown"] 
                  }
              }
          }
          args = [
            "/nginx-ingress-controller",
            "--publish-service=ingress-nginx/ingress-nginx-controller",
            "--election-id=ingress-controller-leader",
            "--ingress-class=nginx",
            "--configmap=ingress-nginx/ingress-nginx-controller",
            "--validating-webhook=:8443",
            "--validating-webhook-certificate=/usr/local/certificates/cert",
            "--validating-webhook-key=/usr/local/certificates/key"
          ]
          security_context {
              run_as_user = 101
              allow_privilege_escalation = true
              capabilities {
                  drop = [
                    "ALL"
                  ]
                  add = [
                    "NET_BIND_SERVICE"
                  ]
              }
          }
          resources {
            limits {
              cpu    = "1"
              memory = "512Mi"
            }
            requests {
              cpu    = "100m"
              memory = "90Mi"
            }
          }
          readiness_probe {
            http_get {
              path = "/healthz"
              port = 10254
              scheme = "HTTP"
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds        = 1
            success_threshold      = 1
            failure_threshold      = 3
          }
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 10254
              scheme = "HTTP"
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds        = 1
            success_threshold      = 1
            failure_threshold      = 3
          }
        }
      }
    }
  }
  depends_on = [
    null_resource.delay,
    kubernetes_namespace.ingress,
    kubernetes_validating_webhook_configuration.ingress,
    kubernetes_job.admission-create,
    kubernetes_role.ingress,
    kubernetes_role.admission,
    kubernetes_cluster_role.ingress,
    kubernetes_cluster_role.admission,
    kubernetes_cluster_role_binding.ingress,
    kubernetes_cluster_role_binding.admission,
    kubernetes_role_binding.ingress,
    kubernetes_role_binding.admission,
    kubernetes_validating_webhook_configuration.ingress,
    kubernetes_service_account.ingress,
    kubernetes_service_account.admission
  ]
}