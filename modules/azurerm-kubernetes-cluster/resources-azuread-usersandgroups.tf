# Service Principal for AKS

resource "azuread_application" "aks_sp" {
  name                       = "aks-sp-${var.prefix}-${var.env}-${var.locationcode}"
  homepage                   = "https://aks-sp-${var.prefix}-${var.env}-${var.locationcode}"
  identifier_uris            = ["https://aks-sp-${var.prefix}-${var.env}-${var.locationcode}"]
  reply_urls                 = ["https://aks-sp-${var.prefix}-${var.env}-${var.locationcode}"]
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
}

resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks_sp.application_id
}

resource "random_password" "aks_sp_pwd" {
  length  = 16
  special = true
  override_special = "_.!"
}

resource "azuread_service_principal_password" "aks_sp_pwd" {
  service_principal_id = azuread_service_principal.aks_sp.id
  value                = random_password.aks_sp_pwd.result
  end_date             = "2024-01-01T01:02:03Z"
}

resource "azurerm_role_assignment" "aks_sp_role_assignment" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aks_sp.id

  depends_on = [
    azuread_service_principal_password.aks_sp_pwd
  ]
}

resource "random_password" "aks_user_pwd" {
  length  = 16
  special = true
  override_special = "_.!"
}

resource "azuread_user" "aks_admin" {
  display_name          = "aks-admin-${var.prefix}-${var.env}-${var.locationcode}"
  password              = random_password.aks_user_pwd.result
  user_principal_name   = "aks-admin-${var.prefix}-${var.env}-${var.locationcode}@${var.tenantdomain}"
}

resource "azuread_group" "aks_admin_group" {
  name    = "aks-admin-${var.prefix}-${var.env}-${var.locationcode}"
  members = [
    azuread_user.aks_admin.object_id
  ]
}

resource "azurerm_role_assignment" "aks_user_role_assignment" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_user.aks_admin.id
}