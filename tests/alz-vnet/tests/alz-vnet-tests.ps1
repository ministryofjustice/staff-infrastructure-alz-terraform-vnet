Describe 'Vnet Validation' {

    #We're repeating a lot of the testing code, so will add a JIRA to look at how we can do this better, e.g. is it possible to have a testing module that we load?
    BeforeAll {

        $testSubscriptionId = "4b068872-d9f3-41bc-9c34-ffac17cf96d6"

        az account set --subscription $testSubscriptionId

        $rg = "rg-pr-alzvnet-001"

        $vnetName = "vnet-pr-alz-vnet-001"
        $addressSpace = @( "192.168.1.0/24", "172.16.1.0/24")

        $subnetServiceEndpoints = @{
            name             = "testsubnet1"
            addressPrefixes  = @("192.168.1.0/28")
            serviceEndpoints = @(
                @{name = "Microsoft.Storage"; provisioningState = "Succeeded" }, 
                @{name = "Microsoft.KeyVault"; provisioningState = "Succeeded" })
        }
        
        $subnetDelegation = @{
            name            = "testsubnet2"
            addressPrefixes = @("172.16.1.0/28")
            delegations     = @(@{
                    name        = "delegation"
                    serviceName = "Microsoft.ContainerInstance/containerGroups"
                    actions     = @("Microsoft.Network/virtualNetworks/subnets/action")    
                })
        }

        $subnetEnforcePolicy = @{
            name            = "testsubnet3"
            addressPrefixes = @("172.16.1.32/28")           
        }

        $subneGatewaySubnet = @{
            name            = "GatewaySubnet"
            addressPrefixes = @("192.168.1.64/26")           
        }
        

        $sutVnet = (az network vnet show -n $vnetName -g $rg -o json | ConvertFrom-Json)
        $sutSubnetServiceEndpoints = (az network vnet subnet show -n $subnetServiceEndpoints['name'] --vnet-name $vnetName -g $rg -o json | ConvertFrom-Json)        
        $sutSubnetDelegation = (az network vnet subnet show -n $subnetDelegation['name'] --vnet-name $vnetName -g $rg -o json | ConvertFrom-Json)        
        $sutSubnetEnforcePrivateLink = (az network vnet subnet show -n $subnetEnforcePolicy['name'] --vnet-name $vnetName -g $rg -o json | ConvertFrom-Json)        
        $sutsubneGatewaySubnet = (az network vnet subnet show -n $subneGatewaySubnet['name'] --vnet-name $vnetName -g $rg -o json | ConvertFrom-Json)        

    }

    Context 'Vnet validation' {
        It "Vnet in correct resource group" { $sutVnet.resourceGroup | Should -Be $rg }
        It "Vnet name is correct" { $sutVnet.name | Should -Be $vnetName }
        It "Vnet is provisioned" { $sutVnet.provisioningState | Should -Be "Succeeded" }
        It "Vnet has correct address space" { Compare-Object -ReferenceObject $sutVnet.addressSpace.addressPrefixes -DifferenceObject $addressSpace | Should -Be $null }
        It "Vnet has four subnet" { $sutVnet.subnets.Length | Should -Be 4 }

    }

    Context "Subnet With Service Endpoints Validation" {
        It "Subnet is in correct vnet" { $sutVnet.subnets.name -contains $subnetDelegation['name']  | Should -Be $true }        
        It "Subnet in correct resource group" { $sutSubnetServiceEndpoints.resourceGroup | Should -Be $rg }
        It "Subnet name is correct" { $sutSubnetServiceEndpoints.name | Should -Be $subnetServiceEndpoints['name'] }
        It "Subnet is provisioned" { $sutSubnetServiceEndpoints.provisioningState | Should -Be "Succeeded" }
        It "Subnet has correct address space" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.addressPrefix -DifferenceObject $subnetServiceEndpoints['addressPrefixes'] | Should -Be $null }
        It "Subnet has correct endpoints" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.serviceEndpoints.service -DifferenceObject $subnetServiceEndpoints['serviceEndpoints'].name | Should -Be $null }
        It "Subnet has endpoints provisioned" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.serviceEndpoints.provisioningState -DifferenceObject $subnetServiceEndpoints['serviceEndpoints'].provisioningState | Should -Be $null }
        
    }

    Context "Subnet With Delegation Validation" {
        It "Subnet is in correct vnet" { $sutVnet.subnets.name -contains $subnetDelegation['name']  | Should -Be $true }   
        It "Subnet in correct resource group" { $sutSubnetDelegation.resourceGroup | Should -Be $rg }
        It "Subnet name is correct" { $sutSubnetDelegation.name | Should -Be $subnetDelegation['name'] }
        It "Subnet is provisioned" { $sutSubnetDelegation.provisioningState | Should -Be "Succeeded" }
        It "Subnet has correct address space" { Compare-Object -ReferenceObject $sutSubnetDelegation.addressPrefix -DifferenceObject $subnetDelegation['addressPrefixes'] | Should -Be $null }            
        It "Subnet has correct delegation" { $sutSubnetDelegation.delegations.serviceName | Should -Be "Microsoft.ContainerInstance/containerGroups" }
        It "Subnet has correct delegation actions" { $sutSubnetDelegation.delegations.actions | Should -Be "Microsoft.Network/virtualNetworks/subnets/action" }
        
    }

    Context "Subnet Enforce Private Link Network Policy" {
        It "Subnet is in correct vnet" { $sutVnet.subnets.name -contains $subnetEnforcePolicy['name']  | Should -Be $true }   
        It "Subnet in correct resource group" { $sutSubnetEnforcePrivateLink.resourceGroup | Should -Be $rg }
        It "Subnet name is correct" { $sutSubnetEnforcePrivateLink.name | Should -Be $subnetEnforcePolicy['name'] }
        It "Subnet is provisioned" { $sutSubnetEnforcePrivateLink.provisioningState | Should -Be "Succeeded" }
        It "Subnet is enforces private link endpoint network policies " { $sutSubnetEnforcePrivateLink.privateEndpointNetworkPolicies | Should -Be $true }
    }

    Context "Subnet Enforce Private Link Network Policy" {
        It "Subnet is in correct vnet" { $sutVnet.subnets.name -contains $subnetEnforcePolicy['name']  | Should -Be $true }   
        It "Subnet in correct resource group" { $sutSubnetEnforcePrivateLink.resourceGroup | Should -Be $rg }
        It "Subnet name is correct" { $sutSubnetEnforcePrivateLink.name | Should -Be $subnetEnforcePolicy['name'] }
        It "Subnet is provisioned" { $sutSubnetEnforcePrivateLink.provisioningState | Should -Be "Succeeded" }
        It "Subnet is enforces private link endpoint network policies " { $sutSubnetEnforcePrivateLink.privateEndpointNetworkPolicies | Should -Be "Disabled" }
    }

}