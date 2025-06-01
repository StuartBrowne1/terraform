resource "azurerm_resource_group" "landingzone" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "landingzone_vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
}

resource "azurerm_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.landingzone.name
  virtual_network_name = azurerm_virtual_network.landingzone_vnet.name
  address_prefixes     = [each.value.address_prefix]
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "landingzone-law"
  location            = azurerm_resource_group.landingzone.location
  resource_group_name = azurerm_resource_group.landingzone.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "vnet_diagnostics" {
  name                       = "vnet-diagnostics"
  target_resource_id         = azurerm_virtual_network.landingzone_vnet.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }

  log {
    category = "VMProtectionAlerts"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
}
