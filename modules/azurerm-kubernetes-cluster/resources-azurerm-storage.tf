resource "azurerm_storage_account" "servicestorage" {
  name                      = "sa${var.prefix}${var.env}${var.locationcode}"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.k8s.name
  account_tier              = "Standard"
  account_replication_type  = "LRS"

  tags = {
    project = var.prefix
    env = var.env
  }
}