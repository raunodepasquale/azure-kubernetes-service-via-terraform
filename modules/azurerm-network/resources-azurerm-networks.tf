# Network used to host the AKS nodes
resource "azurerm_virtual_network" "k8s" {
  name                = "vnet-${var.prefix}-${var.env}-${var.locationcode}"
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
    tags = {
    project = var.prefix
    env = var.env
  }
}

resource "azurerm_subnet" "k8s" {
  name                 = "subnet-${var.prefix}-${var.env}-${var.locationcode}"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.k8s.name
  address_prefixes     = var.subnet_cidr
}