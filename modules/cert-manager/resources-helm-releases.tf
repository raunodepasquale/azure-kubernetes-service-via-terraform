resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
resource "helm_release" "cert-manager" {
  name  = "cert-manager"
  chart = "jetstack/cert-manager"
  repository = data.helm_repository.jetstack.metadata[0].name
  namespace = "cert-manager"
  version = "v.0.15.1"

  set {
    name  = "installCRDs"
    value = "true"
  }
  depends_on = [
    null_resource.delay,
    kubernetes_namespace.cert-manager
  ]
}