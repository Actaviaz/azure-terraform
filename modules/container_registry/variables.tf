variable "resource_grp_name" {
  description = "Name of the resource group."
  default = "single_inst_rsgrp"
}

variable "resource_grp_loc" {
  description = "Location of the resource group."
  default = "westeurope"
}

variable "str_account_name" {
  description = "Name of the storage account."
  default = "containerregstracc"
}

variable "str_account_tier" {
  description = "Tier type for the storage account."
  default = "Standard"
}

variable "str_account_replication" {
  description = "Replication type for the storage account."
  default = "GRS"
}

variable "container_reg_name" {
  description = "Name of the container registry."
  default = "azurecontainerreg"
}

variable "container_reg_admin" {
  description = "Flag that specifies if the admin user is enabled."
  default = true
}

variable "container_reg_sku" {
  description = "The SKU name of the the container registry. Can be Classic, Basic, Standard and Premium."
  default = "Basic"
}
