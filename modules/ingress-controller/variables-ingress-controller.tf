variable "namespace" {
  description = "The name of the namespace used"
  default = "ingress-nginx"
}

variable "aksnoderg" {
  description = "name of the resource group used for aks nodes, where the IP will be created"
}