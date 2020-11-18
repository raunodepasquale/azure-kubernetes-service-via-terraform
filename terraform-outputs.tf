output "id" {
  value = module.kubernetes.id
}

output "kube_config" {
  value = module.kubernetes.kube_config
}

output "client_key" {
  value = module.kubernetes.client_key
}

output "client_certificate" {
  value = module.kubernetes.client_certificate
}

output "cluster_ca_certificate" {
  value = module.kubernetes.cluster_ca_certificate
}

output "aksadmingroup" {
  value = module.kubernetes.aksadmingroup
}

output "aksadminuser" {
  value = module.kubernetes.aksadminuser
}

output "host" {
  value = module.kubernetes.host
}

output "ingress_ip" {
  value = module.ingress.public_ip
}

output "webapphostname" {
  value = lower("${var.webhostname}.${var.webbasedns}")
}




