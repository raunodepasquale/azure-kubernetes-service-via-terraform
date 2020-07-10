variable "node_count" {
  description = "Number of nodes on the AKS cluster node pool"
}

variable "node_min_count" {
  description = "Minimum number of nodes on the AKS cluster node pool in case of autoscale, if no autoscale set equal to null"
}

variable "node_max_count" {
  description = "Maximum number of nodes on the AKS cluster node pool in case of autoscale, if no autoscale set equal to null"
}

variable "vm_size" {
  description = "Azure VM series to be used to create nodes on the node pool in AKS"
}

variable "disk_size" {
  description = "Size, in GB, of the local disk of each node in AKS"
}

variable "max_pods" {
  description = "Maximum number of PODs active on each node in the AKS node pool (110 is the maximum value with kubenet, 30 with Azure CNI)"
}

variable "enable_auto_scaling" {
  description = "Enabling or disabling autoscaling functionality inside the node pool of AKS"
}

variable "enable_node_public_ip" {
  description = "Assign or not a public IP to each node in the node pool of AKS"
}

variable "orchestrator_version" {
  description = "The kubernetes version to be used"
}

variable "network_plugin" {
  description = "The kubernetes network plugin to be used, options are azure and kubenet, see also relation with max pods; if azure selected the attribute pod_cidr must be removed"
}

variable "pod_cidr" {
  description = "The network to be used by PODs, it must not conflict with the nodes subnet or the service subnet. A /24 will be assigned to each node"
}

variable "service_cidr" {
  description = "The network to be used by service inside kubernetes, it must not conflict with the nodes subnet and with the pod subnet"
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). It is the .10 in the service cidr"
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes, it must not conflict with the other networks"
}

