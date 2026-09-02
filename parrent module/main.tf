module "resource_group" {
  source = "../child_module/azurerm_resource_group"
  rgs    = var.resource_groups
}

module "virtual_network" {
  source   = "../child_module/azurerm_virtual_network"
  for_each = var.virtual_networks

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  address_space       = each.value.address_space
  tags                = each.value.tags

  depends_on = [module.resource_group]
}

module "subnet" {
  source   = "../child_module/azurerm_subnet"
  for_each = var.subnets

  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  name                 = each.value.name
  address_prefixes     = each.value.address_prefixes

  depends_on = [module.virtual_network]
}

module "network_security_group" {
  source   = "../child_module/azurerm_network_security_group"
  for_each = var.network_security_groups

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  subnet_id           = module.subnet[each.value.subnet_key].subnet_id
  security_rules      = each.value.security_rules
  tags                = each.value.tags

  depends_on = [module.subnet]
}

module "public_ip" {
  source   = "../child_module/azurerm_public_ip"
  for_each = var.public_ips

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  zones               = each.value.zones
  tags                = each.value.tags

  depends_on = [module.resource_group]
}

module "linux_virtual_machine" {
  source   = "../child_module/azurerm_linux_virtual_machine"
  for_each = var.linux_virtual_machines

  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  name                = each.value.name
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  subnet_id           = module.subnet[each.value.subnet_key].subnet_id
  public_ip_id        = module.public_ip[each.value.public_ip_key].public_ip_id
  os_disk_size_gb     = each.value.os_disk_size_gb
  tags                = each.value.tags

  depends_on = [module.network_security_group, module.public_ip, module.subnet]
}
