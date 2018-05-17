####                                                                ####
#     Mandatory variables that must be set on module instantiation     #
####                                                                ####

variable "resource_grp_name" {
  description = "Name of the resource group."
}

variable "resource_loc" {
  description = "Location of the resources."
}

variable "container_reg_name" {
  description = "Name of the container registry. It works as a DNS prefix so it must be unique in the region."
}

####                     ####
#     Support variables     #
####                     ####

variable "container_reg_admin" {
  description = "Flag that specifies if the admin user is enabled."
  default = true
}

variable "container_reg_sku" {
  description = "The SKU name of the the container registry. Can be Classic, Basic, Standard and Premium."
  default = "Basic"
}
