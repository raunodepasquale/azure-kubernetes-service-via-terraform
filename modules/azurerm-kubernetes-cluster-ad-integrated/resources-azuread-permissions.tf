# a sleep configured to have time for the other resources to be fully deployed (Azure is returing a 200 when command taken but this does not mean resource is propagated)
resource "null_resource" "delay_before_consent" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [
    azuread_service_principal.aks-aad-srv,
    azuread_service_principal.aks-aad-client
  ]
}

resource "null_resource" "grant_srv_admin_constent" {
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.aks-aad-srv.application_id}"
  }
  depends_on = [
    null_resource.delay_before_consent
  ]
}
resource "null_resource" "grant_client_admin_constent" {
  provisioner "local-exec" {
    command = "az ad app permission admin-consent --id ${azuread_application.aks-aad-client.application_id}"
  }
  depends_on = [
    null_resource.delay_before_consent
  ]
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 60"
  }
  depends_on = [
    null_resource.grant_srv_admin_constent,
    null_resource.grant_client_admin_constent
  ]
}