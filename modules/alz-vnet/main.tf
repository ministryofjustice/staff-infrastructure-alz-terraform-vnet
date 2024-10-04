# Deploy hub virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_servers
}

# Deploy hub subnets within virtual network
resource "azurerm_subnet" "subnet" {
  for_each                                  = var.subnet
  name                                      = each.key
  resource_group_name                       = var.resource_group_name
  address_prefixes                          = each.value.address_prefixes
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  service_endpoints                         = each.value.service_endpoints
  private_endpoint_network_policies = each.key != "GatewaySubnet" ? each.value.private_endpoint_network_policies : true
  dynamic "delegation" {
    for_each = each.value.delegations
    content {
      name = delegation.value["name"]
      dynamic "service_delegation" {
        for_each = delegation.value["service_delegation"]
        content {
          name    = service_delegation.value["name"]
          actions = service_delegation.value["actions"]
        }
      }
    }
  }

}

