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
