terraform {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  required_version = "=1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "samojtfstate001"
    resource_group_name  = "rg-terraform-statefiles-001"
    container_name       = "tfstatepullrequest"
    key                  = "alzvnet.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
