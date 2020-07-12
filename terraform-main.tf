# Creaton of an instance of AKS with authentication integrated with Azure AD
# Change the module used for kubernetes to create without Azure AD integration
# The Azure Integration module requires the service principal used to create the applications to have global admin role

module "network" {
    # Module reference via path
    source                  = "./modules/azurerm-network"
    # values for module variables
    prefix                  = var.prefix
    env                     = var.env
    locationcode            = var.locationcode
    location                = var.location
    vnet_cidr               = var.vnet_cidr
    subnet_cidr             = var.subnet_cidr
}
module "kubernetes" {
    # Module reference via path (azurerm-kubernetes-cluster for AKS or azurerm-kubernetes-cluster-ad-integrated to have aks with rbac integrated with Azure AD)
    # azurerm-kubernetes-cluster-ad-integrated requires the services principal used to interact with Azure to have Global Admin rights in Azure AD
    source                  = "./modules/azurerm-kubernetes-cluster"
    # values for module variables
    prefix                  = var.prefix
    env                     = var.env
    locationcode            = var.locationcode
    location                = var.location
    azsubscriptionid        = var.azsubscriptionid
    node_count              = var.node_count
    node_min_count          = var.node_min_count
    node_max_count          = var.node_max_count
    vm_size                 = var.vm_size
    disk_size               = var.disk_size
    max_pods                = var.max_pods
    enable_auto_scaling     = var.enable_auto_scaling
    enable_node_public_ip   = var.enable_node_public_ip
    orchestrator_version    = var.orchestrator_version
    network_plugin          = var.network_plugin
    pod_cidr                = var.pod_cidr
    service_cidr            = var.service_cidr
    docker_bridge_cidr      = var.docker_bridge_cidr
    dns_service_ip          = var.dns_service_ip
    subnet_id               = module.network.subnet_id
}

module "ingress" {
    # Module reference via path
    source                  = "./modules/ingress-controller"
    # values for module variables
    prefix                  = var.prefix
    env                     = var.env
    locationcode            = var.locationcode
    location                = var.location
}

module "cert-manager" {
    # Module reference via path
    source                  = "./modules/cert-manager"
}