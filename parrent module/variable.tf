variable "resource_groups" {
  description = "Map of Azure resource groups to create."
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    rg1 = {
      name     = "bhatt_rg"
      location = "centralindia"
    }
  }
}

variable "virtual_networks" {
  description = "Map of VNet definitions keyed by unique name."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string), {})
  }))
  default = {
    vnet1 = {
      name                = "vnet-demo"
      location            = "centralindia"
      resource_group_name = "bhatt_rg"
      address_space       = ["10.0.0.0/16"]
      tags = {
        environment = "dev"
        project     = "azure-network-demo"
      }
    }
  }
}

variable "subnets" {
  description = "Map of subnets to create within the virtual networks."
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
  default = {
    subnet1 = {
      name                 = "snet-web"
      resource_group_name  = "bhatt_rg"
      virtual_network_name = "vnet-demo"
      address_prefixes     = ["10.0.1.0/24"]
    }
  }
}

variable "network_security_groups" {
  description = "Map of NSGs keyed by subnet relation."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_key          = string
    security_rules = list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range            = optional(string)
      destination_port_range       = optional(string)
      source_address_prefix        = optional(string)
      destination_address_prefix   = optional(string)
      source_port_ranges           = optional(list(string))
      destination_port_ranges      = optional(list(string))
      source_address_prefixes      = optional(list(string))
      destination_address_prefixes = optional(list(string))
    }))
    tags = optional(map(string), {})
  }))
  default = {
    nsg1 = {
      name                = "nsg-demo-web"
      location            = "centralindia"
      resource_group_name = "bhatt_rg"
      subnet_key          = "subnet1"
      security_rules = [
        {
          name                       = "AllowSSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowHTTPS"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
      tags = {
        environment = "dev"
      }
    }
  }
}

variable "public_ips" {
  description = "Map of public IPs to create."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
    zones               = optional(list(string), [])
    tags                = optional(map(string), {})
  }))
  default = {
    pip1 = {
      name                = "pip-demo-web"
      location            = "centralindia"
      resource_group_name = "bhatt_rg"
      allocation_method   = "Static"
      sku                 = "Standard"
      zones               = []
      tags = {
        environment = "dev"
      }
    }
  }
}

variable "linux_virtual_machines" {
  description = "Map of Linux VMs to create in the subnet and attach to public IP."
  type = map(object({
    name                   = string
    location               = string
    resource_group_name    = string
    subnet_key             = string
    public_ip_key          = string
    size                   = string
    admin_username         = string
    admin_password         = string
    os_disk_size_gb        = optional(number, 128)
    source_image_publisher = optional(string, "Canonical")
    source_image_offer     = optional(string, "0001-com-ubuntu-server-jammy")
    source_image_sku       = optional(string, "22_04-lts-gen2")
    source_image_version   = optional(string, "latest")
    tags                   = optional(map(string), {})
  }))
  default = {
    vm1 = {
      name                = "vm-demo-web"
      location            = "centralindia"
      resource_group_name = "bhatt_rg"
      subnet_key          = "subnet1"
      public_ip_key       = "pip1"
      size                = "Standard_B2s"
      admin_username      = "azureuser"
      admin_password      = "P@ssw0rd1234!"
      os_disk_size_gb     = 128
      tags = {
        environment = "dev"
      }
    }
  }
}
