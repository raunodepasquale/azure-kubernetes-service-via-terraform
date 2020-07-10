variable "vnet_cidr" {
  description = "Range of IP of the VNet where to create the subnets for the AKS node pools"
  default = ["172.16.0.0/16"]
}

variable "subnet_cidr" {
  description = "Range of IP of the subnet for the AKS node pools"
  default = ["172.16.10.0/24"]
}