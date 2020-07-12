resource "kubernetes_job" "admission-create" {
  metadata {
    name = "ingress-nginx-admission-create"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
  spec {
    template {
      metadata {
          name = "ingress-nginx-admission-create"
          labels = {
            "app.kubernetes.io/name" = "ingress-nginx"
            "app.kubernetes.io/instance" = "ingress-nginx"
            "app.kubernetes.io/component" = "controller"
          }
      }
      spec {
        restart_policy = "OnFailure"
        service_account_name = "ingress-nginx-admission"
        container {
          name    = "create"
          image   = "docker.io/jettech/kube-webhook-certgen:v1.2.2"
          image_pull_policy = "IfNotPresent"
          args = [
            "create", 
            "--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.ingress-nginx.svc", 
            "--namespace=ingress-nginx", 
            "--secret-name=ingress-nginx-admission"
            ]
          security_context {
              run_as_user = 2000
              run_as_non_root = true
          }  
        }
      }
    }
  }
depends_on = [
    kubernetes_namespace.ingress
]
}

resource "kubernetes_job" "admission-patch" {
  metadata {
    name = "ingress-nginx-admission-patch"
    labels = {
        "app.kubernetes.io/name" = "ingress-nginx"
        "app.kubernetes.io/instance" = "ingress-nginx"
        "app.kubernetes.io/component" = "controller"
    }
    namespace = var.namespace
  }
  spec {
    template {
      metadata {
          name = "ingress-nginx-admission-patch"
          labels = {
            "app.kubernetes.io/name" = "ingress-nginx"
            "app.kubernetes.io/instance" = "ingress-nginx"
            "app.kubernetes.io/component" = "controller"
          }
      }
      spec {
        restart_policy = "OnFailure"
        service_account_name = "ingress-nginx-admission"
        container {
          name    = "patch"
          image   = "docker.io/jettech/kube-webhook-certgen:v1.2.2"
          image_pull_policy = "IfNotPresent"
          
          args = [
            "patch", 
            "--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.ingress-nginx.svc", 
            "--namespace=ingress-nginx", 
            "--patch-mutating=false", 
            "--secret-name=ingress-nginx-admission", 
            "--patch-failure-policy=Fail"
            ]
          security_context {
              run_as_user = 2000
              run_as_non_root = true
          }
        }
      }
    }
  }
depends_on = [
    kubernetes_namespace.ingress
]
}