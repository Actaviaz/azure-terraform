variable "resource_grp_name" {
  description = "Name of the resource group."
  default = "kubernetes_rsgrp"
}

variable "resource_grp_loc" {
  description = "Location of the resource group."
  default = "westeurope"
}

variable "kube_plat_name" {
  description = "Name of the container platform."
  default = "azure_kubernetes"
}

variable "master_count" {
  description = "Number of master nodes. Can be 1,3 or 5."
  default = "3"
}

variable "master_dns_prefix" {
  description = "The DNS Prefix to use for the Container Service master nodes."
  default = "kube-master-xpto"
}

variable "master_user" {
  description = "Name of the Admin user for the container orchestration."
  default = "kube_master"
}

variable "key_path" {
  description = "Path to the public key for ssh auth."
  default = "keys/container_key.pub"
}

variable "kube_agent_pool_name" {
  description = "Name of the container agent pool."
  default = "kube_agent_pool"
}

variable "worker_node_count" {
  description = "Number of worker nodes where the containers will run."
  default = "3"
}

variable "worker_dns_prefix" {
  description = "DNS prefix for the workers."
  default = "kube-worker"
}

variable "worker_vm_size" {
  description = "Size of the VMs for the workers."
  default = "Standard_A0"
}

variable "client_id" {
  description = "ID of the client for API requests. Should be provided on module use."
}

variable "client_secret" {
  description = "Password of the client for API requests. Should be provided on module use."
}

variable "diag_enabled" {
  description = "Flag to mark if diagnostics should be enabled."
  default = false
}
