resource "azurerm_resource_group" "rg" {
  name     = join("-", ["aks", terraform.workspace])
  location = var.location
  tags = local.default_tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = join("-", ["aks", terraform.workspace])
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = join("-", ["aks", terraform.workspace, "1"])
    address_prefix = "10.0.1.0/24"
  }
  tags = local.default_tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = join("-", ["aks", terraform.workspace])
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  node_resource_group = join("-", ["aks", terraform.workspace,"pool"])
  dns_prefix          = join("-", ["aks", terraform.workspace])
  private_cluster_enabled = true 
  kubernetes_version  = var.aks_version
  
  default_node_pool {
    name                   = join("", ["aks", terraform.workspace,"pool"])
    vm_size                = var.aks_pool_vm_size
    availability_zones     = var.availability_zones
    enable_auto_scaling    = true
    min_count              = var.aks_min_count
    max_count              = var.aks_max_count
    node_count             = var.node_count
    #enable_host_encryption = true 
    vnet_subnet_id         = var.vnet_subnet_id
    tags                   = local.default_tags
    orchestrator_version   = var.aks_agent_version
    os_disk_size_gb        = var.os_disk_size_gb
    max_pods               = var.max_pods
  }
  auto_scaler_profile {
  balance_similar_node_groups      = false  
  max_graceful_termination_sec     = "600"  
  new_pod_scale_up_delay           = "0s"  
  scale_down_delay_after_add       = "10m"  
  scale_down_delay_after_delete    = "10s"  
  scale_down_delay_after_failure   = "3m"  
  scale_down_unneeded              = "10m"  
  scale_down_unready               = "20m"  
  scale_down_utilization_threshold = "0.5"  
  scan_interval                    = "10s"  
}

addon_profile {
  http_application_routing {
      enabled   = false  
  }
  kube_dashboard {
      enabled = false  
  }

  aci_connector_linux {
      enabled = false  
  }
  azure_policy {
      enabled = false  
  }
  oms_agent {
      enabled = false  
  }
}

  identity {
    type = "SystemAssigned"
  }

  tags = local.default_tags

  /*
  ingress_application_gateway {
    enabled = true
   }
  */
  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = var.ssh_key
  }
}
network_profile {
  network_plugin      = var.network_plugin
  dns_service_ip      = var.dns_service_ip
  pod_cidr            = var.pod_cidr
  service_cidr        = var.service_cidr
  #network_policy      = var.network_policy
  docker_bridge_cidr  = var.docker_bridge_cidr
  load_balancer_sku   = var.lb_sku
 }
}
