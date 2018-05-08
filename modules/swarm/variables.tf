variable "resource_grp_name" {
  description = "Name of the resource group."
  default = "swarm_rsgrp"
}

variable "resource_grp_loc" {
  description = "Location of the resource group."
  default = "westeurope"
}

variable "swarm_plat_name" {
  description = "Name of the container platform."
  default = "azure_swarm"
}

variable "master_count" {
  description = "Number of master nodes. Can be 1, 3 or 5."
  default = "3"
}

variable "master_dns_prefix" {
  description = "The DNS Prefix to use for the Container Service master nodes."
  default = "swarm-master-xpto"
}

variable "swarm_master_user" {
  description = "Name of the Admin user for the container orchestration."
  default = "swarm_master"
}

variable "key_path" {
  description = "Path to the public key for ssh auth."
  default = "keys/container_key.pub"
}

variable "swarm_agent_pool_name" {
  description = "Name of the container agent pool."
  default = "swarm_agent_pool"
}

variable "worker_node_count" {
  description = "Number of worker nodes where the containers will run."
  default = "3"
}

variable "worker_dns_prefix" {
  description = "DNS prefix for worker nodes."
  default = "swarm-worker"
}

variable "worker_vm_size" {
  description = "Size of the VMs for the workers."
  default = "Standard_A0"
}

variable "diag_enabled" {
  description = "Flag to mark if diagnostics should be enabled."
  default = false
}
