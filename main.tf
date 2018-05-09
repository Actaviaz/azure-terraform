# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

# Create a single instance
module "single_instance" {
  source = "modules/instance/"
}

output "Admin account name" {
  value = "${module.single_instance.admin_user}"
}

output "Admin account password" {
  value = "${module.single_instance.admin_password}"
}

output "Public IP" {
  value = "${module.single_instance.public_ip}"
}

output "Public IP FQDN" {
  value = "${module.single_instance.public_ip_fqdn}"
}

# Create a Kubernetes cluster platform
module "kubernetes_platform" {
  source = "modules/kubernetes"
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
