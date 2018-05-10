variable "rsgrp_name" {
  description = "Name of the resource group, where the extension will be applied."
}

variable "location" {
  description = "Location of the extension."
}

variable "vm_name" {
  description = "The name of the virtual machine."
}

variable "ext_name" {
  description = "Name of the extension."
  default = "ext_vm"
}

variable "ext_pub" {
  description = "The publisher of the extension."
  default = "Microsoft.Compute"
}

variable "ext_type" {
  description = "The type of extension."
  default = "CustomScriptExtension"
}

variable "ext_type_handler_ver" {
  description = "Specifies the version of the extension to use."
  default = "1.9"
}

variable "ext_settings" {
  description = "The settings passed to the extension, these are specified as a JSON object in a string."
  default = "{\"fileUris\": [ \"data/custom_scripts/jenkins_install.sh\" ] , \"commandToExecute\": \"bash jenkins_install.sh\" }"
}
