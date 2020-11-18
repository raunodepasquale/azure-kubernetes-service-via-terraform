resource "azurerm_public_ip" "ingress" {
  name                = "pip-${var.prefix}-${var.env}-${var.locationcode}"
  resource_group_name = var.aksnoderg
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    project = var.prefix
    env = var.env
  }
}