resource "azurerm_linux_virtual_machine" "linux" {
  name                = "linux-machine"
  resource_group_name = azurerm_resource_group.terraform_group.name
  location            = azurerm_resource_group.terraform_group.location
  size                = "Standard_B1s"
  admin_username      = "hojae"
  network_interface_ids = [azurerm_network_interface.linux_nic.id]

  admin_ssh_key {
    username   = "hojae"
    public_key = file("~/.ssh/terraform_key/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
	cloud = "Azure"
	os = "Linux"
  }
}

