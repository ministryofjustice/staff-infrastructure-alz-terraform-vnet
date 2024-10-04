# Build vnet resources using the vnet module and run tests to validate the config

locals {
  subname = "pr"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-pr-alzvnet-001"
  location = "UK South"
}


module "vnet" {
  source = "../../modules/alz-vnet"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet              = var.subnet
  vnet_name           = "vnet-pr-alz-vnet-001"
  vnet_address_space  = var.vnet_address_space
}