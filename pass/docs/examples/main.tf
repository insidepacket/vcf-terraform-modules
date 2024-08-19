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

provider "vcf" {
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  sddc_manager_host     = var.sddc_manager_host
  allow_unverified_tls  = true
}

provider "vault" {
  address = var.vault_address
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