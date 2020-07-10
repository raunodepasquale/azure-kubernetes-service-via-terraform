# Resource Group for the AKS Cluster
resource "azurerm_resource_group" "k8s" {
  name     = "rg-aks-${var.prefix}-${var.env}-${var.locationcode}"
  location = var.location 
    tags = {
    project = var.prefix
    env = var.env
  }
}