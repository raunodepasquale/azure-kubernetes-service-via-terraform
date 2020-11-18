resource "random_password" "databasepassword" {
  length  = 12
  special = true
  override_special = "_!£"
}