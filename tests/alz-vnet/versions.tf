terraform {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  required_version = "=1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.96.0"
    }
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

