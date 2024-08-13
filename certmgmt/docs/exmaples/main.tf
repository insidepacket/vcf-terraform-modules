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
  source                 = "./modules/certmgmt"
  sddc_manager_username  = var.sddc_manager_username
  sddc_manager_password  = var.sddc_manager_password
  ca_server_url          = var.ca_server_url
  ca_secret              = var.ca_secret
  vcf_domain_id          = var.vcf_domain_id
  cert_email             = var.cert_email
  cert_key_size          = var.cert_key_size
  cert_organization      = var.cert_organization
  cert_organization_unit = var.cert_organization_unit
  cert_state             = var.cert_state
  cert_locality          = var.cert_locality
}

