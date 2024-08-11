data "vcf_domain" "domain1" {
  domain_id = var.vcf_domain_id
}

resource "vcf_certificate_authority" "ca" {
  microsoft {
    secret        = var.ca_secret
    server_url    = var.ca_server_url
    template_name = var.ca_template_name
    username      = var.ca_username
  }
}

resource "vcf_csr" "vcenter_csr" {
  domain_id         = data.vcf_domain.domain1.domain_id
  country           = var.cert_country
  fqdn              = data.vcf_domain.domain1.vcenter_configuration[0].fqdn
  email             = var.cert_email
  key_size          = var.cert_key_size
  locality          = var.cert_locality
  state             = var.cert_state
  organization      = var.cert_organization
  organization_unit = var.cert_organization_unit
  resource          = "VCENTER"
}

resource "vcf_csr" "nsx_csr" {
  domain_id         = data.vcf_domain.domain1.domain_id
  country           = var.cert_country
  fqdn              = data.vcf_domain.domain1.nsx_configuration[0].vip_fqdn
  email             = var.cert_email
  key_size          = var.cert_key_size
  locality          = var.cert_locality
  state             = var.cert_state
  organization      = var.cert_organization
  organization_unit = var.cert_organization_unit
  resource          = "NSXT_MANAGER"
}

resource "vcf_certificate" "vcenter_cert" {
  depends_on = [
    vcf_csr.vcenter_csr,
    vcf_certificate.nsx_cert
  ]
  csr_id = vcf_csr.vcenter_csr.id
  ca_id  = vcf_certificate_authority.ca.id
}

resource "vcf_certificate" "nsx_cert" {
  depends_on = [
    vcf_csr.nsx_csr
  ]
  csr_id = vcf_csr.nsx_csr.id
  ca_id  = vcf_certificate_authority.ca.id
}

locals {
  nsx_manager_node_map = { for idx, node in data.vcf_domain.domain1.nsx_configuration[0].nsx_manager_node : idx => node }
}

resource "vcf_csr" "nsx_manager_csr" {
  for_each = local.nsx_manager_node_map

  country           = var.cert_country
  domain_id         = data.vcf_domain.domain1.domain_id
  fqdn              = each.value.fqdn
  email             = var.cert_email
  key_size          = var.cert_key_size
  locality          = var.cert_locality
  state             = var.cert_state
  organization      = var.cert_organization
  organization_unit = var.cert_organization_unit
  resource          = "NSXT_MANAGER"

}

resource "vcf_certificate" "nsx_manager_cert" {
  for_each = local.nsx_manager_node_map

  csr_id = vcf_csr.nsx_manager_csr[each.key].id
  ca_id  = vcf_certificate_authority.ca.id
}

output "vcenter_fqdn" {
  value       = data.vcf_domain.domain1.vcenter_configuration[0].fqdn
  description = "vcenter dns name"
}

output "count" {
  value       = length(data.vcf_domain.domain1.nsx_configuration[0].nsx_manager_node)
  description = "the number of nsxm node in nsxcluster"
}

output "csrs" {
  value       = vcf_csr.nsx_manager_csr
  description = "all csrs"
  sensitive   = true
}

