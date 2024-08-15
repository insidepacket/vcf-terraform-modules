terraform {
  required_providers {
    vcf = {
      source  = "vmware/vcf"
      version = "~> 0.10.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0"
    }
  }
}

module "update-vcf-vrslcm-pwd" {
  source                = "./modules/passwdmgmt"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  vault_address         = var.vault_address
  resource_type         = "VRSLCM"
  account_type          = "SYSTEM"
}

output "last_rotate_time" {
  value = module.update-vcf-vrslcm-pwd.last_rotate_time
}