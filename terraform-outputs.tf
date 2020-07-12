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

output "host" {
  value = module.kubernetes.host
}
/*
# Remove comments on these two lines in case of usage of the AKS with AD Integration
output "server-app-id" {
  value = module.kubernetes.server-app-id
}
output "client-app-id" {
  value = module.kubernetes.client-app-id
}
*/
output "ingress_ip" {
  value = module.ingress.public_ip
}