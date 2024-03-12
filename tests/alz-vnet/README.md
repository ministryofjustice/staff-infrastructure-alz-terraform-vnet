<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ../../../modules/version1.0.0/alz-vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The spoke name | `string` | `"pr"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | This variable contains the subnet details | <pre>map(object({<br>    address_prefixes                          = list(string)<br>    private_endpoint_network_policies_enabled = bool<br>    service_endpoints                         = list(string)<br>    delegations = list(object({<br>      name = string<br>      service_delegation = list(object({<br>        name = string<br>      actions = list(string) }))<br>    }))<br>  }))</pre> | <pre>{<br>  "GatewaySubnet": {<br>    "address_prefixes": [<br>      "192.168.1.64/26"<br>    ],<br>    "delegations": [],<br>    "private_endpoint_network_policies_enabled": true,<br>    "service_endpoints": []<br>  },<br>  "testsubnet1": {<br>    "address_prefixes": [<br>      "192.168.1.0/28"<br>    ],<br>    "delegations": [],<br>    "private_endpoint_network_policies_enabled": false,<br>    "service_endpoints": [<br>      "Microsoft.Storage",<br>      "Microsoft.KeyVault"<br>    ]<br>  },<br>  "testsubnet2": {<br>    "address_prefixes": [<br>      "172.16.1.0/28"<br>    ],<br>    "delegations": [<br>      {<br>        "name": "delegation",<br>        "service_delegation": [<br>          {<br>            "actions": [<br>              "Microsoft.Network/virtualNetworks/subnets/action"<br>            ],<br>            "name": "Microsoft.ContainerInstance/containerGroups"<br>          }<br>        ]<br>      }<br>    ],<br>    "private_endpoint_network_policies_enabled": false,<br>    "service_endpoints": []<br>  },<br>  "testsubnet3": {<br>    "address_prefixes": [<br>      "172.16.1.32/28"<br>    ],<br>    "delegations": [],<br>    "private_endpoint_network_policies_enabled": true,<br>    "service_endpoints": []<br>  }<br>}</pre> | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | subscription id | `string` | `"4b068872-d9f3-41bc-9c34-ffac17cf96d6"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Generic tags for supported resources | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant id | `string` | `"0bb413d7-160d-4839-868a-f3d46537f6af"` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | The virtual network allocated address spaces. | `list(string)` | <pre>[<br>  "192.168.1.0/24",<br>  "172.16.1.0/24"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
