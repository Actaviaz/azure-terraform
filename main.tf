# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

#### Creates the resource groups needed for the platform
# Creates the Resource Group for the Jenkins Instance
resource "azurerm_resource_group" "management_rs_grp" {
  name = "management_rsgrp"
  location = "${var.infra_loc}"
}

# Creates the Resource Group for the container platform
resource "azurerm_resource_group" "container_rg" {
  name = "container_mgmt_rsgrp"
  location = "${var.infra_loc}"
}

#### Create the manangement network and subnet
# Create the management network
resource "azurerm_virtual_network" "management_network" {
  name = "management_network"
  resource_group_name = "${azurerm_resource_group.management_rs_grp.name}"
  location = "${azurerm_resource_group.management_rs_grp.location}"
  address_space = ["192.168.0.0/16"]
  dns_servers = []
}

# Create the management subnet
resource "azurerm_subnet" "management_subnet" {
  name = "management_subnet"
  resource_group_name = "${azurerm_resource_group.management_rs_grp.name}"
  virtual_network_name = "${azurerm_virtual_network.management_network.name}"
  address_prefix = "192.168.1.0/24"
}

####                       ####
#     Platform Definition     #
####                       ####
variable "jenkins_install_script" {
  description = "File location for the cloud init conf."
  default = "data/custom_scripts/jenkins_install"
}

# Create the JenkinsCI instance and install the required software
module "jenkinsci_instance" {
  # Loads the module to create an instance
  source = "modules/instance/"
  ####                                    ####
  #     Support infrastructure variables     #
  ####                                    ####
  resource_grp_name = "${azurerm_resource_group.management_rs_grp.name}"
  resource_loc = "${azurerm_resource_group.management_rs_grp.location}"
  network_name = "${azurerm_virtual_network.management_network.name}"
  subnet_id = "${azurerm_subnet.management_subnet.id}"
  sec_grp_name = "jenkins_sc_grp"
  nic_name = "jenkins_mgmt_nic"
  sec_rule_in_name = "Inbound access for Jenkins machine"
  os_custom_data = "${file(var.jenkins_install_script)}"
  ####                          ####
  #     User defined variables     #
  ####                          ####
  pub_ip_domain_label = "${var.jenkings_dns_prefix}"
  single_instance_name = "${var.jenkins_instance_name}"
  single_instance_hostname = "${var.jenkings_dns_prefix}"
  instance_admin_user = "${var.jenkins_ssh_username}"
  sec_rule_in_destination_range = "${var.port_dest_range}"
  key_path = "${var.public_key_path}"
  os_disk_name = "jenkinsosdisk"
}

output "Jenkins SSH Username" {
  value = "${module.jenkinsci_instance.admin_user}"
}

output "Jenkins Public IP" {
  value = "${module.jenkinsci_instance.public_ip}"
}

output "Jenkins Public IP FQDN" {
  value = "${module.jenkinsci_instance.public_ip_fqdn}"
}

output "Jenkins usage" {
  value = "${module.jenkinsci_instance.usage}"
}

output "Jenkins web access" {
  value = "${module.jenkinsci_instance.web}"
}

# Create a Kubernetes cluster platform
module "kubernetes_platform" {
  # Loads the module
  source = "modules/kubernetes"
  # Credentials since Kubernetes needs it to deploy
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  # Allocates the cluster in the resource group for it
  resource_grp_name = "${azurerm_resource_group.container_rg.name}"
  resource_loc = "${azurerm_resource_group.container_rg.location}"
  ####                          ####
  #     User defined variables     #
  ####                          ####
  kube_plat_name = "${var.container_plat_name}"
  master_count = "${var.master_node_count}"
  master_dns_prefix = "${var.master_dns}"
  master_user = "${var.master_ssh_user}"
  key_path = "${var.key_root_folder}${var.master_ssh_key}"
  worker_node_count = "${var.worker_node_count}"
  worker_vm_size = "${var.worker_vm_type}"
}

output "Kubernetes SSH Username" {
  value = "${module.kubernetes_platform.kube_admin_user}"
}

output "Kubernetes Master FQDN" {
  value = "${module.kubernetes_platform.kube_master_fqdn}"
}

output "Kubernetes usage" {
  value = "${module.kubernetes_platform.usage}"
}

/*
# Create a Swarm cluster platform
module "swarm_platform" {
  source = "modules/swarm"
  # Loads the module
  source = "modules/kubernetes"
  # Allocates the cluster in the resource group for it
  resource_grp_name = "${azurerm_resource_group.container_rg.name}"
  resource_loc = "${azurerm_resource_group.container_rg.location}"
  ####                          ####
  #     User defined variables     #
  ####                          ####
  swarm_plat_name = "${var.container_plat_name}"
  master_count = "${var.master_node_count}"
  master_dns_prefix = "${var.master_dns}"
  master_user = "${var.master_ssh_user}"
  key_path = "${var.key_root_folder}${var.master_ssh_key}"
  worker_node_count = "${var.worker_node_count}"
  worker_vm_size = "${var.worker_vm_type}"
}

output "Swarm SSH Username" {
  value = "${module.swarm_platform.swarm_admin_user}"
}
output "Swarm Master FQDN" {
  value = "${module.swarm_platform.swarm_master_fqdn}"
}

output "Swarm usage" {
  value = "${module.swarm_platform.usage}"
}
*/

# Creates the Container Registry, for your container images
module "container_registry" {
  source = "modules/container_registry"
  # Will use the same resource group as the container platform
  resource_grp_name = "${azurerm_resource_group.container_rg.name}"
  resource_loc = "${azurerm_resource_group.container_rg.location}"
  /*
  * User defined variables
  */
  container_reg_name = "${var.acr_dns_prefix}"
}

output "Container Registry Login Server" {
  value = "${module.container_registry.container_registry_login_server}"
}

output "Container Registry Admin User" {
  value = "${module.container_registry.container_registry_admin_username}"
}

output "Container Registry Admin Password" {
  value = "${module.container_registry.container_registry_admin_password}"
}
