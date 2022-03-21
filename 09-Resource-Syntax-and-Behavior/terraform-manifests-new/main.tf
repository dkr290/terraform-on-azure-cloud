# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {
  name = "test-RG"
  location = "northeurope"
}