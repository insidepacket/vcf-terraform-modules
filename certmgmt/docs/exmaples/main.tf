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

module "renew-wld-certs" {
  source                = "./modules/certmgmt"
  sddc_manager_username = var.sddc_manager_username
  sddc_manager_password = var.sddc_manager_password
  ca_secret             = var.ca_secret
  vcf_domain_id         = "1f6d229e-1218-4033-b1cc-f0efa390d512"
  cert_locality         = "San Francisco"
}

