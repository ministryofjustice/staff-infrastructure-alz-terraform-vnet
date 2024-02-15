provider "azurerm" {
  alias = "spoke"
  features {
    key_vault {
      recover_soft_deleted_key_vaults = false
      purge_soft_delete_on_destroy    = true
    }
  }
  tenant_id       = "0bb413d7-160d-4839-868a-f3d46537f6af"
  subscription_id = "4b068872-d9f3-41bc-9c34-ffac17cf96d6" # Devl testing
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "vm_module_tests" {}

resource "azurerm_resource_group" "vnet_module_tests" {
  name     = "rg-alz-vnet-test-001"
  location = "UK South"
  provider = azurerm.spoke
}

resource "azurerm_virtual_network" "vm_module_tests" {
  name                = "vnet-alz-vm-test-001"
  location            = azurerm_resource_group.vnet_module_tests.location
  resource_group_name = azurerm_resource_group.vnet_module_tests.name
  address_space       = ["192.168.99.0/24"]
  provider            = azurerm.spoke

  subnet {
    name           = "snet-alz-vm-test-001"
    address_prefix = "192.168.99.0/24"
  }
}
