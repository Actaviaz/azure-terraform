output "resource_group_name" {
  value = "${azurerm_resource_group.kubernetes_rg.name}"
}

output "resource_group_location" {
  value = "${azurerm_resource_group.kubernetes_rg.location}"
}

output "kube_id" {
  value = "${azurerm_container_service.kubernetes.id}"
}

output "kube_master_fqdn" {
  value = "${lookup(azurerm_container_service.kubernetes.master_profile[0], "fqdn")}"
}

output "kube_worker_fqdn" {
  value = "${lookup(azurerm_container_service.kubernetes.agent_pool_profile[0], "fqdn")}"
}

output "kube_admin_user" {
  value = "${var.master_user}"
}
