# Resource Group for the VNet and Subnet
resource "azurerm_resource_group" "vnet" {
  name     = "rg-vnet-${var.prefix}-${var.env}-${var.locationcode}"
  location = var.location
    tags = {
    project = var.prefix
    env = var.env
  }
}