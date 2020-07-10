# K8s cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.prefix}-${var.env}-${var.locationcode}"
  location            = var.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = "aks-${var.prefix}-${var.env}-${var.locationcode}"

  default_node_pool {
    name            = "default"
    type            = "VirtualMachineScaleSets"
    node_count      = var.node_count
    min_count       = var.node_min_count
    max_count       = var.node_max_count
    vm_size         = var.vm_size
    os_disk_size_gb = var.disk_size
    max_pods        = var.max_pods
    enable_auto_scaling = var.enable_auto_scaling
    enable_node_public_ip = var.enable_node_public_ip
    orchestrator_version = var.orchestrator_version
    vnet_subnet_id = azurerm_subnet.k8s.id
  }
  service_principal {
    client_id     = azuread_application.aks_sp.application_id
    client_secret = random_password.aks_sp_pwd.result
  }
  role_based_access_control {
    enabled = true
  }
  network_profile {
      network_plugin = var.network_plugin
      pod_cidr = var.pod_cidr
      service_cidr = var.service_cidr
      docker_bridge_cidr = var.docker_bridge_cidr
      dns_service_ip = var.dns_service_ip
  }
  addon_profile {
    kube_dashboard {
      enabled = true
      }
  }
  tags = {
    project = var.prefix
    env = var.env
  }
  depends_on = [
    null_resource.delay,
    azuread_service_principal.aks-aad-srv,
    azurerm_role_assignment.aks_sp_role_assignment,
    azuread_service_principal_password.aks_sp_pwd
  ]
}


