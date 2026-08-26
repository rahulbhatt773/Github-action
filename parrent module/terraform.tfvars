rgs = {
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

vnet = {
  vnet1 = {
    name          = "vnet_rahul"
    location      = "centralindia"
    rgs           = "bhatt_rg"
    address_space = ["10.1.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name            = "rahul_front"
    rgs             = "bhatt_rg"
    vnet_name       = "vnet_rahul"
    address_prefixe = ["10.1.1.0/24"]
  }
  subnet2 = {
    name            = "rahul_back"
    rgs             = "bhatt_rg"
    vnet_name       = "vnet_rahul"
    address_prefixe = ["10.1.2.0/24"]
  }
}