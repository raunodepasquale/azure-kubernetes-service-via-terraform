# Role assignment
# Cluster role binding to AAD group
resource "kubernetes_cluster_role_binding" "aad_integration" {
  metadata {
    name = "aks-${var.prefix}-${var.env}-${var.locationcode}-admins"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind = "Group"
    name = azuread_group.aks-aad-clusteradmins.id
  }
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
