
resource "azurerm_route_table" "route_table" {
  depends_on = [
    azurerm_subnet.subnet
  ]
  count                         = var.resource_network_subnet_count
  name                          = "${local.resource_route_table_name}${count.index + 1}"
  location                      = var.resource_location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
}

resource "azurerm_route" "udr_internet" {
  count               = var.resource_network_subnet_count
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.route_table[count.index].name
  name                = "UDR-Internet"
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "subnet_association" {
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
  count          = var.resource_network_subnet_count
  subnet_id      = azurerm_subnet.subnet[count.index].id
  route_table_id = azurerm_route_table.route_table[count.index].id
}