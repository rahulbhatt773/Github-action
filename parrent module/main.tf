module "rg" {
  source = "../child_module/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../child_module/azurerm_virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../child_module/azurerm_subnet"
  subnet     = var.subnet
}