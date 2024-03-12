terraform {
  required_version = ">=1.5.7"
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  required_providers {
    azurerm = ">=3.33.0"
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

locals {
  subname = "pr"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-pr-alzvnet-001"
  location = "UK South"
  tags     = var.tags
}



module "vnet" {
  source = "../../modules/alz-vnet"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet              = var.subnet
  tags                = var.tags
  vnet_name           = "vnet-pr-alz-vnet-001"
  vnet_address_space  = var.vnet_address_space
}
