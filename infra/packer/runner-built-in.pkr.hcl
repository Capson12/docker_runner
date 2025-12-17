packer{
    required_plugins {
        azure = {
            source = "github.com/hashicorp/azure"
            version = ">= 1.0.0"
        }
    }
}

source "azure-arm" "github-runner" {
    subscription_id = var.azure_subscription_id
    client_id       = var.azure_client_id
    client_secret   = var.azure_client_secret
    tenant_id       = var.azure_tenant_id

    managed_image_resource_group_name = "rg-github-runner"
    managed_image_name                = "img-github-runner"

    os_type         = "Linux"
    image_publisher = "Canonical"
    image_offer     = "UbuntuServer"
    image_sku       = "22.04-LTS"
    location        = "uk-south"

    vm_size = "Standard_B1s"

    ssh_username = "azureuser"
    ssh_private_key_file = var.ssh_private_key_file
}

