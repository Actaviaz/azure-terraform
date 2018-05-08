variable "resource_grp_name" {
  description = "Name of the resource group."
  default = "containers_rsgrp"
}

variable "resource_grp_loc" {
  description = "Location of the resource group."
  default = "westeurope"
}

variable "container_plat_name" {
  description = "Name of the container platform."
  default = "azure_container_plat"
}

variable "master_dns_prefix" {
  description = "The DNS Prefix to use for the Container Service master nodes."
  default = "kube-master"
}

variable "container_master_user" {
  description = "Name of the Admin user for the container orchestration."
  default = "cont_master"
}

variable "key_path" {
  description = "Path to the public key for ssh auth."
  default = "keys/container_key.pub"
}

variable "cont_agent_pool_name" {
  description = "Name of the container agent pool."
  default = "cont_agent_pool"
}

variable "worker_node_count" {
  description = "Number of worker nodes where the containers will run."
  default = "3"
}

variable "worker_os" {
  description = "OS for worker nodes."
  default = "Linux"
}

variable "os_disk_size" {
  description = "Disk size for the OS of the worker nodes, in GB."
  default = 30
}

variable "worker_vm_size" {
  description = "Size of the VMs for the workers."
  default = "Standard_A0"
}

variable "client_id" {
  description = "Should be on the credentials file if not you must generate it."
}

variable "client_secret" {
  description = "Should be on the credentials file if not you must generate it."
}
