variable "vnet_cidr" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
}

variable "subnet_cidr" {
  description = "Range of IP of the subnet for the AKS node pools"
}