output "resource_group_name" {
  value       = azurerm_virtual_network.vnet.resource_group_name
  description = "This outout block outputs the vnet resource group name"
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_subnets_names" {
  description = "The names of subnets created inside the new vNet"
  value       = { for k, v in azurerm_subnet.subnet : k => v.name }
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the new vNet"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "vnet_subnets_ids" {
  description = "The ids of subnets created inside the new vNet. This is pretty hacky, but it's documented so I'm absolved. Essentially this is used for the hub to correct an impedance mismatch"
  value       = [for k in azurerm_subnet.subnet : k.id if k.name != "GatewaySubnet"]
}
