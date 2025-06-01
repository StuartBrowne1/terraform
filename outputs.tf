output "resource_group_name" {
  value = azurerm_resource_group.landingzone.name
}

output "vnet_id" {
  value = azurerm_virtual_network.landingzone_vnet.id
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics.id
}
