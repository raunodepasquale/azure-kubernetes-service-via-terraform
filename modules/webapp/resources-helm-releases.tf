resource "helm_release" "prestashop" {
  name  = "prestashop"
  chart = "prestashop"
  repository = "./modules/webapp"
  version = "1.0.0"

  set {
    name  = "namespace.name"
    value = var.namespace
  }
  set {
    name  = "namespace.cpu.limit"
    value = var.cpu_limit
  }
  set {
    name  = "namespace.cpu.request"
    value = var.cpu_request
  }
  set {
    name  = "namespace.memory.limit"
    value = var.memory_limit
  }
  set {
    name  = "namespace.memory.request"
    value = var.memory_request
  }
  set {
    name  = "namespace.quota.cpu.request"
    value = var.quota_cpu_request
  }
  set {
    name  = "namespace.quota.memory.request"
    value = var.quota_memory_request
  }
  set {
    name  = "namespace.quota.cpu.limit"
    value = var.quota_cpu_limit
  }
  set {
    name  = "namespace.quota.memory.limit"
    value = var.quota_memory_limit
  }
  set {
    name  = "namespace.quota.pod"
    value = var.quota_pod
  }
  set {
    name  = "app.name"
    value = var.appname
  }
  set {
    name  = "app.hostname"
    value = var.hostname
  }
  set {
    name  = "database.disk"
    value = var.database_disk
  }
  set {
    name  = "database.password"
    value = base64encode(random_password.databasepassword.result)
  }
  set {
    name  = "issuer.name"
    value = var.issuer_name
  }
}
