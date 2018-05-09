output "swarm_id" {
  value = "${azurerm_container_service.swarm.id}"
}

output "swarm_master_fqdn" {
  value = "${lookup(azurerm_container_service.swarm.master_profile[0], "fqdn")}"
}

output "swarm_worker_fqdn" {
  value = "${lookup(azurerm_container_service.swarm.agent_pool_profile[0], "fqdn")}"
}

output "swarm_admin_user" {
  value = "${var.swarm_master_user}"
}
