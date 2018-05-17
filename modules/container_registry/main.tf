# Creates the container registry platform
resource "azurerm_container_registry" "container_registry" {
  resource_group_name = "${var.resource_grp_name}"
  location = "${var.resource_loc}"
  name = "${var.container_reg_name}"
  admin_enabled = "${var.container_reg_admin}"
  sku = "${var.container_reg_sku}"
}
