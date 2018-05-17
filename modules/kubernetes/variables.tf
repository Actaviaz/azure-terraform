####                                                                ####
#     Mandatory variables that must be set on module instantiation     #
####                                                                ####

variable "resource_loc" {
  description = "Location of the resources."
}

variable "resource_grp_name" {
  description = "Name of the resource group where the resources of the container platform will be built."
}

variable "kube_plat_name" {
  description = "Name of the container platform."
}

variable "master_count" {
  description = "Number of master nodes. Can be 1,3 or 5."
}

variable "master_dns_prefix" {
  description = "The DNS Prefix to use for the Container Service master nodes."
}

variable "master_user" {
  description = "Name of the Admin user for the container orchestration."
}

variable "key_path" {
  description = "Path to the public key for ssh auth."
}

variable "worker_node_count" {
  description = "Number of worker nodes where the containers will run."
}

variable "worker_vm_size" {
  description = "Size of the VMs for the workers."
}

variable "client_id" {
  description = "ID of the client for API requests. Should be provided on module use."
}

variable "client_secret" {
  description = "Password of the client for API requests. Should be provided on module use."
}

####                     ####
#     Support variables     #
####                     ####

variable "worker_dns_prefix" {
  description = "DNS prefix for the workers."
  default = "kube-agent"
}

variable "diag_enabled" {
  description = "Flag to mark if diagnostics should be enabled."
  default = false
}
