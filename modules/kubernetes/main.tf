# Creates the Resource Group for the container platform
resource "azurerm_resource_group" "containers_rg" {
  name = "${var.resource_grp_name}"
  location = "${var.resource_grp_loc}"
}

# Creates the container platform
resource "azurerm_kubernetes_cluster" "container_orch" {
  resource_group_name = "${azurerm_resource_group.containers_rg.name}"
  location = "${azurerm_resource_group.containers_rg.location}"
  name = "${var.container_plat_name}"
  dns_prefix = "${var.master_dns_prefix}"
  linux_profile {
    admin_username = "${var.container_master_user}"
    ssh_key {
      key_data = "${file(var.key_path)}"
    }
  }
  agent_pool_profile {
    name = "${var.cont_agent_pool_name}"
    count = "${var.worker_node_count}"
    os_type = "${var.worker_os}"
    os_disk_size_gb = "${var.os_disk_size}"
    vm_size = "${var.worker_vm_size}"
  }
  service_principal {
    client_id = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
}
