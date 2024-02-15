# ALZ Vnet

This is a simple module that creates a vnet and subnet(s)

The configuration of each subnet is specified individually.

Note that the GatewaySubnet will always have the enforce_private_link_endpoint_network_policies set to false regardless of the set value

Quite possibly this should be extended to the bastion subnet.

At the time of writing we're still using terraform 0.13.3, which doesn't allow optional attributes in an object, I know there are potential work arounds but seems like an appropriate compromise for now

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | A list of custom DNS servers, which are assigned to the VNET. | `list(any)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the VNET is deployed. | `string` | n/a | yes |
| <a name="input_private_endpoint_network_policies_enabled"></a> [private\_endpoint\_network\_policies\_enabled](#input\_private\_endpoint\_network\_policies\_enabled) | This setting is needed to allow private endpoints. If the subnet will get a private endpoint this must be set to true | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name for the management network resource group | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | This variable contains the subnet details | <pre>map(object({<br>    address_prefixes                          = list(string)<br>    private_endpoint_network_policies_enabled = bool<br>    service_endpoints                         = list(string)<br>    delegations = list(object({<br>      name = string<br>      service_delegation = list(object({<br>        name = string<br>      actions = list(string) }))<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags applied to the VNET. | `map(any)` | n/a | yes |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The virtual network allocated address space. | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | The name of the virtual network resource. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | This outout block outputs the vnet resource group name |
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the newly created vNet |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location) | The location of the newly created vNet |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The Name of the newly created vNet |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets) | The ids of subnets created inside the new vNet |
| <a name="output_vnet_subnets_ids"></a> [vnet\_subnets\_ids](#output\_vnet\_subnets\_ids) | The ids of subnets created inside the new vNet. This is pretty hacky, but it's documented so I'm absolved. Essentially this is used for the hub to correct an impedance mismatch |
| <a name="output_vnet_subnets_names"></a> [vnet\_subnets\_names](#output\_vnet\_subnets\_names) | The names of subnets created inside the new vNet |
<!-- END_TF_DOCS -->
