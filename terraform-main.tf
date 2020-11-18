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
    # Module reference via path 
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
    admin_group_objects_ids = module.admin_group_objects_ids
    api_server_authorized_ip_ranges = module.api_server_authorized_ip_ranges
    balance_similar_node_groups = module.balance_similar_node_groups
    max_graceful_termination_sec = module.max_graceful_termination_sec
    scale_down_delay_after_add = module.scale_down_delay_after_add
    scale_down_unneeded = module.scale_down_unneeded
    scan_interval = module.scan_interval
    scale_down_utilization_threshold = module.scale_down_utilization_threshold
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
    namespace               = var.certmanager-namespace
    emailproduction         = var.certmanager-emailproduction
    emailstaging            = var.certmanager-emailstaging
}