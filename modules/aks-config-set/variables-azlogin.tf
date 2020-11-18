variable "aksadminuser" {
    description = "the username to authenticate against azure tenant"
}
variable "aksadminuserpassword" {
    description = "the password to authenticate against azure tenant"
}
variable "azsubscriptionid" {
    description = "the subscription into which to operate"
}
variable "aksname" {
    description = "the name of the aks resource"
}
variable "aksresourcegroup" {
    description = "the resource group where the aks resource is located"
}