resource "azurerm_virtual_machine_extension" "jenkins_install" {
  resource_group_name  = "${var.rsgrp_name}"
  location = "${var.location}"
  virtual_machine_name = "${var.vm_name}"
  name = "${var.ext_name}"
  publisher = "${var.ext_pub}"
  type = "${var.ext_type}"
  type_handler_version = "${var.ext_type_handler_ver}"
  settings = "${var.ext_settings}"
}
