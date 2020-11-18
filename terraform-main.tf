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
    admin_group_objects_ids = var.admin_group_objects_ids
    api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
    balance_similar_node_groups = var.balance_similar_node_groups
    max_graceful_termination_sec = var.max_graceful_termination_sec
    scale_down_delay_after_add = var.scale_down_delay_after_add
    scale_down_unneeded = var.scale_down_unneeded
    scan_interval = var.scan_interval
    scale_down_utilization_threshold = var.scale_down_utilization_threshold
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

module "cloudflare-dns" {
    # Module reference via path
    source                  = "./modules/cloudflare-dns"
    cloudflare_zone_id = var.cloudflare_zone_id 
    hostname = var.webhostname
    publicip = module.ingress.public_ip
    proxied = var.proxied
    dnsttl = var.dnsttl
 }

 module "webapp" {
    # Module reference via path
    source                  = "./modules/webapp"
    hostname = var.webappfqdnhostname
    namespace = var.webappnamespace
    cpu_limit = var.cpu_limit
    cpu_request = var.cpu_request
    memory_limit = var.memory_limit
    memory_request = var.memory_request
    quota_cpu_request = var.quota_cpu_request
    quota_memory_request = var.quota_memory_request
    quota_cpu_limit = var.quota_cpu_limit
    quota_memory_limit = var.quota_memory_limit
    quota_pod = var.quota_pod
    database_disk = var.database_disk
    issuer_name = var.webappissuer_name
 }