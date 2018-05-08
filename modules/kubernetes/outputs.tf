output "container_orch_id" {
  value = "${azurerm_kubernetes_cluster.container_orch.id}"
}

output "container_orch_kube_config" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config_raw}"
}

output "username" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.username}"
}

output "password" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.password}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.container_orch.kube_config.0.host}"
}
