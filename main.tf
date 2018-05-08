# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
  tenant_id = "${var.tenant_id}"
}

# Create a single instance
/*module "single_instance" {
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
}*/

# Create a Kubernetes cluster platform
/*module "kubernetes_platform" {
  source = "modules/kubernetes"
  client_id = "${var.client_id}"
  client_secret = "${var.client_secret}"
}

output "Container Host" {
  value = "${module.kubernetes_platform.host}"
}

output "Admin account username" {
  value = "${module.kubernetes_platform.username}"
}

output "Admin account password" {
  value = "${module.kubernetes_platform.password}"
}

output "Client key" {
  value = "${module.kubernetes_platform.client_key}"
}

output "Client Certificate" {
  value = "${module.kubernetes_platform.client_certificate}"
}

output "Cluster CA certificate" {
  value = "${module.kubernetes_platform.cluster_ca_certificate}"
}

output "Kubernetes config" {
  value = "${module.kubernetes_platform.container_orch_kube_config}"
}*/

# Create a Swarm cluster platform
module "swarm_platform" {
  source = "modules/swarm"
}
