variable "location" {
    type = string 
    default = "Australia East"
  
}

variable "aks_pool_vm_size" {
  type = string
  default = "Standard_DS2_v2"
}

variable "aks_min_count" {
  type = number 
  default = "2"
}
variable "aks_max_count" {
  type = number
  default = "5"
}
variable "node_count" {
  type = number
  default = "2"
}

variable "vnet_subnet_id" {
  type = string
  default = ""
}

variable "aks_version" {
  type = string
  default = "1.19.9"
}

variable "aks_agent_version" {
  type = string
  default = "1.19.9"
}
variable "os_disk_size_gb" {
  type = number 
  default = "128"
}

variable "dns_service_ip" {
   type = string 
  default = "10.0.0.10"
}
variable "pod_cidr" {
   type = string 
  default = "10.244.0.0/16"
}
variable "service_cidr" {
   type = string 
  default = "10.0.0.0/16"
}
variable "docker_bridge_cidr" {
   type = string 
  default = "172.17.0.1/16"
}
variable "network_plugin" {
  type = string
  default = "kubenet"
}

variable "network_policy" {
  type = string
  default = "azure"
}
variable "lb_sku" {
  type = string
  default = "Standard"
}

variable "max_pods" {
  type = number 
  default = "110"
}

variable "availability_zones" {
  type = list
  default = ["1","2","3"]
}

variable "ssh_key" {
  type = string
  default = ""
}