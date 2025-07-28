# /infra/outputs.tf

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "acr_login_server" {
  value       = azurerm_container_registry.main.login_server
  description = "The login server for the Azure Container Registry."
}

output "acr_name" {
  value = azurerm_container_registry.main.name
}

output "web_app_name" {
  value       = azurerm_linux_web_app.main.name
  description = "The name of the Azure Web App."
}