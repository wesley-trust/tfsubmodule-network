resource "azurerm_network_security_group" "network_security_group" {
  depends_on = [
    azurerm_subnet.subnet
  ]
  count               = var.resource_network_subnet_count
  name                = "${local.resource_network_security_group_name}${count.index + 1}"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "network_security_group_association" {
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
  count                     = var.resource_network_subnet_count
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.network_security_group[count.index].id
}
