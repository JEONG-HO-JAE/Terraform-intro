resource "azurerm_resource_group" "terraform_group" {
  name     = "practiceTerraform"
  location = "Korea Central"
}

resource "azurerm_public_ip" "linux_public_ip" {
  name                = "linux_public_ip"
  resource_group_name = azurerm_resource_group.terraform_group.name
  location            = azurerm_resource_group.terraform_group.location
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "window_public_ip" {
  name                = "window_public_ip"
  resource_group_name = azurerm_resource_group.terraform_group.name
  location            = azurerm_resource_group.terraform_group.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network" "terraform_network" {
  name                = "network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terraform_group.location
  resource_group_name = azurerm_resource_group.terraform_group.name
}


resource "azurerm_subnet" "terraform_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.terraform_group.name
  virtual_network_name = azurerm_virtual_network.terraform_network.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "linux_nic" {
  name                = "linux_nic"
  location            = azurerm_resource_group.terraform_group.location
  resource_group_name = azurerm_resource_group.terraform_group.name

  ip_configuration {
    name                          = "nic"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.linux_public_ip.id
  }
}

resource "azurerm_network_interface" "window_nic" {
  name                = "window_nic"
  location            = azurerm_resource_group.terraform_group.location
  resource_group_name = azurerm_resource_group.terraform_group.name

  ip_configuration {
    name                          = "nic"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
   private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.window_public_ip.id
  }
}



resource "azurerm_network_security_group" "linux_nsg" {
  name                = "ssh_nsg"
  location            = azurerm_resource_group.terraform_group.location
  resource_group_name = azurerm_resource_group.terraform_group.name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "window_nsg" {
  name                = "rdp_nsg"
  location            = azurerm_resource_group.terraform_group.location
  resource_group_name = azurerm_resource_group.terraform_group.name

  security_rule {
    name                       = "allow_rdp_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges     = ["3389", "5985", "5986"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface_security_group_association" "window_association" {
  network_interface_id      = azurerm_network_interface.window_nic.id
  network_security_group_id = azurerm_network_security_group.window_nsg.id
}

resource "azurerm_network_interface_security_group_association" "linux_association" {
  network_interface_id      = azurerm_network_interface.linux_nic.id
  network_security_group_id = azurerm_network_security_group.linux_nsg.id
}


