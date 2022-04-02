resource "azurerm_subnet" "websubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.web_subnet_address
}

resource "azurerm_network_security_group" "web_subnet_nsg" {
    name = "${azurerm_subnet.websubnet.name}-nsg"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
  depends_on = [
    azurerm_network_security_rule.web_nsg_rule_inbound
  ]
}

locals {
  web_inbound_ports_map = {
      "100" : "80",
      "110" : "443",
      "120" : "22"

  }
}

resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_ports_map
  name                        = "rule-port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}