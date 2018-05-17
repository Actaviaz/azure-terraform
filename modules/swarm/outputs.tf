output "swarm_master_fqdn" {
  value = "${lookup(azurerm_container_service.swarm.master_profile[0], "fqdn")}"
}

output "swarm_admin_user" {
  value = "${var.master_user}"
}

output "usage" {
  value = "ssh -i <private_key> ${var.master_user}@${lookup(azurerm_container_service.swarm.master_profile[0], "fqdn")}"
}
