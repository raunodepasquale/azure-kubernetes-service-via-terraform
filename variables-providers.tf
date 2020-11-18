variable "azsubscriptionid" {
  description = "The Azure Subscription in which all resources in this example should be provisioned (sensitive data, not stored in git repo)"
}

variable "azclientid" {
  description = "The Azure Client ID  used to provision all resources (sensitive data, not stored in git repo)"
}

variable "azclientsecret" {
  description = "The secred used to authenticate the Azure Client ID  used to provision all resources (sensitive data, not stored in git repo)"
}

variable "aztenantid" {
  description = "The Azure Tentant in which all resources in this example should be provisioned (sensitive data, not stored in git repo)"
}

variable "cloudflare_email" {
  description = "the email of the account used to interact with Cloudflare APIs to configure DNS record"
}
variable "cloudflare_api_key" {
  description = "The API Key used to authenticate against Cloudflare APIs to configure DNS record"
}