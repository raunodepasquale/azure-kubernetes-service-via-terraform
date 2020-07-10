# Resource Group for the Ingress balancer and IP
resource "azurerm_resource_group" "ingress" {
  name     = "rg-ingress-${var.prefix}-${var.env}-${var.locationcode}"
  location = var.location
    tags = {
    project = var.prefix
    env = var.env
  }
}