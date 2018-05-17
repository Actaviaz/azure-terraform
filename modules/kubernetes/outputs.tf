output "kube_master_fqdn" {
  value = "${lookup(azurerm_container_service.kubernetes.master_profile[0], "fqdn")}"
}

output "kube_admin_user" {
  value = "${var.master_user}"
}

output "usage" {
  value = "ssh -i <private_key> ${var.master_user}@${lookup(azurerm_container_service.kubernetes.master_profile[0], "fqdn")}"
}
