variable "prefix" {
  description = "The name of the project, used to compose names and tags"
}

variable "env" {
  description = "The name of the environment as production, staging, development, demo"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be provisioned (used to identify actual Azure region for resource provisioning)"
}

variable "locationcode" {
  description = "The Azure Region in which all resources in this example should be provisioned (two letters version used on names)"
}

