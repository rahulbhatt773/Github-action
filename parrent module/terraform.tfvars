resource_groups = {
  rg1 = {
    name     = "bhatt_rg"
    location = "centralindia"
  }
    rg2 = {
    name     = "bhatt2_rg"
    location = "centralindia"
  }
    rg3 = {
    name     = "bhatt3_rg"
    location = "centralindia"
  }
}

virtual_networks = {
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

subnets = {
  subnet1 = {
    name                 = "snet-web"
    resource_group_name  = "bhatt_rg"
    virtual_network_name = "vnet-demo"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

network_security_groups = {
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

public_ips = {
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

linux_virtual_machines = {
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
