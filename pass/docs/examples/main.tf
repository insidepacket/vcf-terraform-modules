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
  backend "s3" {
    key = "vcf-tf-passwd-mgmt/terraform.tfstate"
  }
}

module "update-vcf-esx-service-pwd" {
  source                = "./modules/pass"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  resource_type         = "ESXI"
  account_type          = "SERVICE"
}

module "update-vcf-esx-service-vault" {
  source                = "./modules/support/vault"
  vault_address         = var.vault_address
  secrets = module.update-vcf-esx-service-pwd.secrets
}


module "update-vcf-esx-user-pwd" {
  source                = "./modules/pass"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  resource_type         = "ESXI"
  account_type          = "USER"
}

module "update-vcf-esx-user-vault" {
  source                = "./modules/support/vault"
  vault_address         = var.vault_address
  secrets = module.update-vcf-esx-user-pwd.secrets
}
