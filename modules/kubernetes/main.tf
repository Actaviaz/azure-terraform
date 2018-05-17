# Variable composition
locals {
  agent_pool_name = "${var.kube_plat_name}-ag_pool"
}

# Creates the container platform
resource "azurerm_container_service" "kubernetes" {
  resource_group_name = "${var.resource_grp_name}"
  location = "${var.resource_loc}"
  name = "${var.kube_plat_name}"
  orchestration_platform = "Kubernetes"
  master_profile {
    count = "${var.master_count}"
    dns_prefix = "${var.master_dns_prefix}"
  }
  linux_profile {
    admin_username = "${var.master_user}"
    ssh_key {
      key_data = "${file(var.key_path)}"
    }
  }
  agent_pool_profile {
    name = "${local.agent_pool_name}"
    count = "${var.worker_node_count}"
    dns_prefix = "${var.worker_dns_prefix}"
    vm_size = "${var.worker_vm_size}"
  }
  service_principal {
    client_id = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }
  diagnostics_profile {
    enabled = "${var.diag_enabled}"
  }
}
