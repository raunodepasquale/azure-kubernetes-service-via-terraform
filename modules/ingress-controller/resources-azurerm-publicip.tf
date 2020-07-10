resource "azurerm_public_ip" "ingress" {
  name                = "pip-${var.prefix}-${var.env}-${var.locationcode}"
  resource_group_name = azurerm_resource_group.ingress.name
  location            = azurerm_resource_group.ingress.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    project = var.prefix
    env = var.env
  }
}