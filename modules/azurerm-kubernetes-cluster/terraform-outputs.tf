output "id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "client_key" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
}

output "host" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "aksadmingroup" {
  value = azuread_group.aks_admin_group.name
}

output "aksadminuser" {
  value = "aks-admin-${var.prefix}-${var.env}-${var.locationcode}@${var.tenantdomain}"
}

output "aksadminuserpassword" {
  value = random_password.aks_user_pwd.result
}

output "aksname" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aksreourcegroup" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}