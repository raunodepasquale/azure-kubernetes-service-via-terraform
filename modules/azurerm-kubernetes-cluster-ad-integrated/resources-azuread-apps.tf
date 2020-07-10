# AAD K8s Backend App

resource "azuread_application" "aks-aad-srv" {
  name                       = "aks-${var.prefix}-${var.env}-${var.locationcode}-srv"
  homepage                   = "https://aks-${var.prefix}-${var.env}-${var.locationcode}-srv"
  identifier_uris            = ["https://aks-${var.prefix}-${var.env}-${var.locationcode}-srv"]
  reply_urls                 = ["https://aks-${var.prefix}-${var.env}-${var.locationcode}-srv"]
  type                       = "webapp/api"
  group_membership_claims    = "All"
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = false
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61"
      type = "Role"
    }
    resource_access {
      id   = "06da0dbc-49e2-44d2-8312-53f166ab848a"
      type = "Scope"
    }
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d"
      type = "Scope"
    }
  }
  required_resource_access {
    resource_app_id = "00000002-0000-0000-c000-000000000000"
    resource_access {
      id   = "311a71cc-e848-46a1-bdf8-97ff7156d8e6"
      type = "Scope"
    }
  }
}

resource "azuread_service_principal" "aks-aad-srv" {
  application_id = azuread_application.aks-aad-srv.application_id
}

resource "random_password" "aks-aad-srv" {
  length  = 16
  special = true
}

resource "azuread_application_password" "aks-aad-srv" {
  application_object_id = azuread_application.aks-aad-srv.object_id
  value                 = random_password.aks-aad-srv.result
  end_date              = "2024-01-01T01:02:03Z"
}


# AAD AKS kubectl app

resource "azuread_application" "aks-aad-client" {
  name       = "aks-${var.prefix}-${var.env}-${var.locationcode}-client"
  homepage   = "https://aks-${var.env}-${var.locationcode}-client"
  reply_urls = ["https://aks-${var.prefix}-${var.env}-${var.locationcode}-client"]
  type       = "native"
  required_resource_access {
    resource_app_id = azuread_application.aks-aad-srv.application_id
    resource_access {
      id   = azuread_application.aks-aad-srv.oauth2_permissions[0].id
      type = "Scope"
    }
  }
  depends_on = [
    azuread_application.aks-aad-srv
  ]
}

resource "azuread_service_principal" "aks-aad-client" {
  application_id = azuread_application.aks-aad-client.application_id
}
