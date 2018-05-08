# Creates the Resource Group for the Swarm platform
resource "azurerm_resource_group" "swarm_rg" {
  name = "${var.resource_grp_name}"
  location = "${var.resource_grp_loc}"
}

# Creates the container platform
resource "azurerm_container_service" "swarm" {
  resource_group_name = "${azurerm_resource_group.swarm_rg.name}"
  location = "${azurerm_resource_group.swarm_rg.location}"
  name = "${var.swarm_plat_name}"
  orchestration_platform = "Swarm"
  master_profile {
    count = "${var.master_count}"
    dns_prefix = "${var.master_dns_prefix}"
  }
  linux_profile {
    admin_username = "${var.swarm_master_user}"
    ssh_key {
      key_data = "${file(var.key_path)}"
    }
  }
  agent_pool_profile {
    name = "${var.swarm_agent_pool_name}"
    count = "${var.worker_node_count}"
    dns_prefix = "${var.worker_dns_prefix}"
    vm_size = "${var.worker_vm_size}"
  }
  diagnostics_profile {
    enabled = "${var.diag_enabled}"
  }
}
