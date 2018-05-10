# Creates a storage account for the container registry platform
/*resource "azurerm_storage_account" "container_reg_str_acc" {
  resource_group_name = "${var.resource_grp_name}"
  location = "${var.resource_grp_loc}"
  name = "${var.str_account_name}"
  account_tier = "${var.str_account_tier}"
  account_replication_type = "${var.str_account_replication}"
}*/

# Creates the container registry platform
resource "azurerm_container_registry" "container_registry" {
  resource_group_name = "${var.resource_grp_name}"
  location = "${var.resource_grp_loc}"
#  storage_account_id = "${azurerm_storage_account.container_reg_str_acc.id}"
  name = "${var.container_reg_name}"
  admin_enabled = "${var.container_reg_admin}"
  sku = "${var.container_reg_sku}"
}
