# FQDN is divided in two arguments, using the example in the description fields, the resulting name would be mysite.mydomain.com
# If this module is used together with the Cloudflare DNS one, the webbasedns must be coerent with the zone configured for Cloudflare
variable "webhostname" {
  description = "The hostname to be used to access the web application, as example: mysite"
}
variable "webbasedns" {
  description = "The base DNS zone to be used to compose the FQDN of the web applications, as example: mydomain.com"
}

variable "webappfqdnhostname" {
  description = lower("${var.webhostname}.${var.webbasedns}")
}

variable "webappnamespace" {
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

variable "database_disk" {
  description = "The disk space to be provisioned for the database"
  default = "4gi"
}

variable "webappissuer_name" {
  description = "The issuers to be used to release the certificate"
  default = "letsencrypt-production"
}

