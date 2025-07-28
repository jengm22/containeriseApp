# /infra/main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider azurerm {
  features {}
}

# Create a unique string to append to resource names
resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

# 1. Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Container Registry (ACR)
resource "azurerm_container_registry" "main" {
  name                = "${var.app_name_prefix}acr${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true # Required for the Web App to pull images easily
}

# 3. App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name_prefix}-asp-${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "F1" # Free tier
}

# 4. Web App for Containers
# /infra/main.tf

# ... (other resources are still correct) ...

# 4. Web App for Containers (CORRECTED AND MODERNIZED)
resource "azurerm_linux_web_app" "main" {
  name                = "${var.app_name_prefix}-wa-${random_string.unique.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  # By providing the DOCKER app settings below, Azure automatically
  # computes the linux_fx_version. We must NOT set it ourselves.
  site_config {
    always_on = false # The only setting we need here for this simple app
  }

  # THIS IS THE KEY CHANGE
  # We now define the container image directly in app_settings.
  app_settings = {
    "DOCKER_CUSTOM_IMAGE_NAME" = "mcr.microsoft.com/appsvc/staticsite:latest"
    "WEBSITES_PORT"            = "3000"
  }

  identity {
    type = "SystemAssigned"
  }
}

# The role assignment remains correct and is crucial for security.
resource "azurerm_role_assignment" "acrpull_to_webapp" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.main.identity[0].principal_id
}