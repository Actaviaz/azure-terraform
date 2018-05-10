# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

variable "jenkins_install_script" {
  description = "File location for the cloud init conf."
  default = "data/custom_scripts/jenkins_install.txt"
}

# Create the JenkinsCI instance and install the required software
module "jenkinsci_instance" {
  source = "modules/instance/"
  resource_grp_name = "management_rg"
  storage_account_name = "managementstracc"
  sec_grp_name = "management_sc_grp"
  network_name = "management_network"
  subnet_name = "management_subnet"
  nic_name = "jenkins_nic"
  nic_ip_conf_name = "jenkins_nic_conf"
  pub_ip_name = "jenkins_pub_ip"
  pub_ip_domain_label = "jenkins-xpto"
  single_instance_name = "jenkins"
  os_disk_name = "jenkinsdisk"
  single_instance_hostname = "JenkinsCI"
  instance_admin_user = "jenk_adm"
  sec_rule_in_name = "Inbound access for SSH and Web access"
  sec_rule_in_destination_range = ["22","8080"]
  os_custom_data = "${file(var.jenkins_install_script)}"
}

output "Jenkins Admin account name" {
  value = "${module.jenkinsci_instance.admin_user}"
}

output "Jenkins Admin account password" {
  value = "${module.jenkinsci_instance.admin_password}"
}

output "Jenkins Public IP" {
  value = "${module.jenkinsci_instance.public_ip}"
}

output "Jenkins Public IP FQDN" {
  value = "${module.jenkinsci_instance.public_ip_fqdn}"
}

# Create a Kubernetes cluster platform
module "kubernetes_platform" {
  source = "modules/kubernetes"
  resource_grp_loc = "${module.jenkinsci_instance.resource_group_loc}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
}

output "Kubernetes admin username" {
  value = "${module.kubernetes_platform.kube_admin_user}"
}

output "Kubernetes Master FQDN" {
  value = "${module.kubernetes_platform.kube_master_fqdn}"
}

output "Kubernetes Worker FQDN" {
  value = "${module.kubernetes_platform.kube_worker_fqdn}"
}

module "container_registry" {
  source = "modules/container_registry"
  resource_grp_name = "${module.kubernetes_platform.resource_group_name}"
  resource_grp_loc = "${module.kubernetes_platform.resource_group_location}"
  container_reg_name = "azcontregxpto"
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

/*
# Create a Swarm cluster platform
module "swarm_platform" {
  source = "modules/swarm"
}

output "Swarm Master FQDN" {
  value = "${module.swarm_platform.swarm_master_fqdn}"
}

output "Swarm Worker FQDN" {
  value = "${module.swarm_platform.swarm_worker_fqdn}"
}

output "Swarm Master Admin" {
  value = "${module.swarm_platform.swarm_admin_user}"
}
*/
