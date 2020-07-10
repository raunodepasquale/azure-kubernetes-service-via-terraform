output "public_ip" {
  value = azurerm_public_ip.ingress.ip_address
}
