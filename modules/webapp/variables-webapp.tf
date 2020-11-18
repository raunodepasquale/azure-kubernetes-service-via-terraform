variable "namespace" {
  description = "The name of the namespace used to host the webapp"
}

variable "cpu_limit" {
  description = "The default CPU Limit"
  default = "250m"
}

variable "cpu_request" {
  description = "The default CPU rquest"
  default = "50m"
}

variable "memory_limit" {
  description = "The default memory limit"
  default = "512Mi"
}

variable "memory_request" {
  description = "The default memory request"
  default = "128Mi"
}

variable "quota_cpu_request" {
  description = "The namespace quota for cpu request"
  default = "2"
}

variable "quota_memory_request" {
  description = "The namespace quota for memory request"
  default = "2048Mi"
}

variable "quota_cpu_limit" {
  description = "The namespace quota for cpu limit"
  default = "2"
}

variable "quota_memory_limit" {
  description = "The namespace quota for memory limit"
  default = "4Gi"
}

variable "quota_pod" {
  description = "The namespace quota for number of active pod"
  default = "5"
}

variable "hostname" {
  description = "The FQDN of the web app"
}

variable "database_disk" {
  description = "The disk space to be provisioned for the database"
  default = "4gi"
}

variable "issuer_name" {
  description = "The issuers to be used to release the certificate"
  default = "letsencrypt-production"
}

