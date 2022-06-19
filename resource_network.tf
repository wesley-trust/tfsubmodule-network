# Define virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = local.resource_virtual_network_name
  address_space       = ["${var.resource_address_space}"]
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  dns_servers         = var.resource_dns_servers

  tags = {
    environment = var.resource_environment
    role        = var.resource_network_role
    deployment  = var.resource_deployment
  }
}

resource "azurerm_subnet" "subnet" {
  count                                          = var.resource_network_subnet_count
  name                                           = "${local.resource_subnet_name}-${count.index + 1}"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = [local.resource_cidrsubnet[count.index]]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}
