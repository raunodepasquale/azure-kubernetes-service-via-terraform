provider "azurerm" {
    version = "=2.36.0"
    features {}
    subscription_id = var.azsubscriptionid
    client_id = var.azclientid
    client_secret = var.azclientsecret
    tenant_id = var.aztenantid
} 

provider "azuread" {
  version = "=1.0.0"
  subscription_id = var.azsubscriptionid
  client_id = var.azclientid
  client_secret = var.azclientsecret
  tenant_id = var.aztenantid
}

provider "kubernetes" {
  version = "1.13.3"
  host                   = module.kubernetes.host
  client_certificate     = base64decode(module.kubernetes.client_certificate)
  client_key             = base64decode(module.kubernetes.client_key)
  cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
}

provider "helm" {
  version = "1.3.2"
  kubernetes {
    host     = module.kubernetes.host

    client_certificate     = base64decode(module.kubernetes.client_certificate)
    client_key             = base64decode(module.kubernetes.client_key)
    cluster_ca_certificate = base64decode(module.kubernetes.cluster_ca_certificate)
  }
}

provider "null" {
  version = "3.0.0"
}

provider "random" {
  version = "3.0.0"
}