resource "azurerm_windows_virtual_machine" "window" {
  name                = "window-machine"
  resource_group_name = azurerm_resource_group.terraform_group.name
  location            = azurerm_resource_group.terraform_group.location
  size                = "Standard_B1s"
  admin_username      = "hojae"
  admin_password      = "Ghwo1916037!#%"
  network_interface_ids = [azurerm_network_interface.window_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = {
	cloud = "Azure"
	os = "Windows"
  }

provision_vm_agent = true
allow_extension_operations = true

}


resource "azurerm_virtual_machine_extension" "example" {
  name                 = "winrm-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.window.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

    settings = <<SETTINGS
    {
        "fileUris": [ "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1" ],
        "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ConfigureRemotingForAnsible.ps1"
    }
SETTINGS
}
