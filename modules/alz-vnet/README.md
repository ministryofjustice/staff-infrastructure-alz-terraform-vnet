# ALZ Vnet

This is a simple module that creates a vnet and subnet(s)

The configuration of each subnet is specified individually.

Note that the GatewaySubnet will always have the enforce_private_link_endpoint_network_policies set to false regardless of the set value

Quite possibly this should be extended to the bastion subnet.

At the time of writing we're still using terraform 0.13.3, which doesn't allow optional attributes in an object, I know there are potential work arounds but seems like an appropriate compromise for now

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                               | Version  |
| ------------------------------------------------------------------ | -------- |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >=3.14.0 |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=3.14.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                 | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name                                                                                                                                                         | Description                                                                                                           | Type                                                                                                                                                                                                                                                                                                            | Default | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_dns_servers"></a> [dns_servers](#input_dns_servers)                                                                                           | A list of custom DNS servers, which are assigned to the VNET.                                                         | `list(any)`                                                                                                                                                                                                                                                                                                     | `[]`    |    no    |
| <a name="input_location"></a> [location](#input_location)                                                                                                    | The location where the VNET is deployed.                                                                              | `string`                                                                                                                                                                                                                                                                                                        | n/a     |   yes    |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private_endpoint_network_policies_enabled](#input_private_endpoint_network_policies_enabled) | This setting is needed to allow private endpoints. If the subnet will get a private endpoint this must be set to true | `bool`                                                                                                                                                                                                                                                                                                          | `false` |    no    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name)                                                                   | The name for the management network resource group                                                                    | `string`                                                                                                                                                                                                                                                                                                        | n/a     |   yes    |
| <a name="input_subnet"></a> [subnet](#input_subnet)                                                                                                          | This variable contains the subnet details                                                                             | <pre>map(object({<br> address_prefixes = list(string)<br> private_endpoint_network_policies_enabled = bool<br> service_endpoints = list(string)<br> delegations = list(object({<br> name = string<br> service_delegation = list(object({<br> name = string<br> actions = list(string) }))<br> }))<br> }))</pre> | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                                                | A map of tags applied to the VNET.                                                                                    | `map(any)`                                                                                                                                                                                                                                                                                                      | n/a     |   yes    |
| <a name="input_vnet_address_space"></a> [vnet_address_space](#input_vnet_address_space)                                                                      | The virtual network allocated address space.                                                                          | `list(string)`                                                                                                                                                                                                                                                                                                  | n/a     |   yes    |
| <a name="input_vnet_name"></a> [vnet_name](#input_vnet_name)                                                                                                 | The name of the virtual network resource.                                                                             | `string`                                                                                                                                                                                                                                                                                                        | n/a     |   yes    |

## Outputs

| Name                                                                                         | Description                                                                                                                                                                      |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <a name="output_resource_group_name"></a> [resource_group_name](#output_resource_group_name) | This outout block outputs the vnet resource group name                                                                                                                           |
| <a name="output_vnet_address_space"></a> [vnet_address_space](#output_vnet_address_space)    | The address space of the newly created vNet                                                                                                                                      |
| <a name="output_vnet_id"></a> [vnet_id](#output_vnet_id)                                     | The id of the newly created vNet                                                                                                                                                 |
| <a name="output_vnet_location"></a> [vnet_location](#output_vnet_location)                   | The location of the newly created vNet                                                                                                                                           |
| <a name="output_vnet_name"></a> [vnet_name](#output_vnet_name)                               | The Name of the newly created vNet                                                                                                                                               |
| <a name="output_vnet_subnets"></a> [vnet_subnets](#output_vnet_subnets)                      | The ids of subnets created inside the new vNet                                                                                                                                   |
| <a name="output_vnet_subnets_ids"></a> [vnet_subnets_ids](#output_vnet_subnets_ids)          | The ids of subnets created inside the new vNet. This is pretty hacky, but it's documented so I'm absolved. Essentially this is used for the hub to correct an impedance mismatch |
| <a name="output_vnet_subnets_names"></a> [vnet_subnets_names](#output_vnet_subnets_names)    | The names of subnets created inside the new vNet                                                                                                                                 |

<!-- END_TF_DOCS -->
