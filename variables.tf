####                        ####
#     Credential variables     #
####                        ####

variable "subscription_id" {
  description = "Should be on the credentials file if not you must generate it."
}

variable "client_id" {
  description = "Should be on the credentials file if not you must generate it."
}

variable "client_secret" {
  description = "Should be on the credentials file if not you must generate it."
}

variable "tenant_id" {
  description = "Should be on the credentials file if not you must generate it."
}

####                         ####
#     Global Azure Settings     #
####                         ####

variable "infra_loc" {
  description = "Sets the location for your Azure resources. Check the Azure locations for more info."
  default = "westeurope"
}

####                     ####
#     Jenkins variables     #
####                     ####

variable "jenkings_dns_prefix" {
  description = "Prefix for the Jenkins machine FQDN. Must be unique in the region."
  default = "jenkins-xpto"
}

variable "jenkins_instance_name" {
  description = "Name of the jenkins instance."
  default = "jenkins"
}

variable "jenkins_ssh_username" {
  description = "Name of the jenkins user for ssh access to the machine."
  default = "jenk_adm"
}

variable "port_dest_range" {
  description = "Inbound ports to open for the Jenkins machine. Must be in list form (either empty or by ports)."
  default = ["22","8080"]
}

variable "public_key_path" {
  description = "Path to the public key to be used in ssh authentication. Can be a relative path in the project folder."
  default = "keys/linux_key.pub"
}

####                                           ####
#     Container Management Platform variables     #
####                                           ####

variable "container_plat_name" {
  description = "Name for your implementation of the container management platform."
  default = "azure_kubernetes"
}

variable "master_node_count" {
  description = "Number of master nodes for your container management platform. Can be 1,3 or 5."
  default = "1"
}

variable "master_dns" {
  description = "Prefix for the master nodes FQDN. Must be unique in the region."
  default = "kube-master-xpto"
}

variable "key_root_folder" {
  description = "Root folder where the keys are located (leave trailling slash). Can be a relative path to the root of the project."
  default = "keys/"
}

variable "master_ssh_user" {
  description = "Name of the ssh user, to access the Container Management masters."
  default = "kube_master"
}

variable "master_ssh_key" {
  description = "Name of the public key (*.pub) for the ssh user, to access the Container Management masters."
  default = "container_key.pub"
}

variable "worker_node_count" {
  description = "Number of worker nodes for your container management platform. Has to be at least > 0."
  default = "3"
}

variable "worker_vm_type" {
  description = "Type of VM for the worker nodes. See Azure type names for more info."
  default = "Standard_A0"
}

####                                         ####
#     Container Registry Platform variables     #
####                                         ####

variable "acr_dns_prefix" {
  description = "Name and DNS prefix for the Container Registry. Must be unique in the region."
  default = "azcontregxpto"
}
