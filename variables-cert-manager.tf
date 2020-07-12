variable "certmanager-namespace" {
  description = "The name of the namespace used"
  default = "cert-manager"
}

variable "certmanager-emailproduction" {
  description = "The email to be used to configure the production cluster-issuer"
}

variable "certmanager-emailstaging" {
  description = "The email to be used to configure the staging cluster-issuer"
}