variable "resource_group_name" {
  type        = string
  description = "The name for the management network resource group"
}

variable "location" {
  type        = string
  description = "The location where the VNET is deployed."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network resource."
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The virtual network allocated address space."
}

variable "subnet" {
  type = map(object({
    address_prefixes                          = list(string)
    private_endpoint_network_policies_enabled = bool
    service_endpoints                         = list(string)
    delegations = list(object({
      name = string
      service_delegation = list(object({
        name = string
      actions = list(string) }))
    }))
  }))
  description = "This variable contains the subnet details"
}

variable "dns_servers" {
  type        = list(any)
  description = "A list of custom DNS servers, which are assigned to the VNET."
  default     = []
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  default     = false
  description = "This setting is needed to allow private endpoints. If the subnet will get a private endpoint this must be set to true"
}

variable "tags" {
  type        = map(any)
  description = "A map of tags applied to the VNET."
}
