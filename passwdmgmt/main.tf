data "vcf_credentials" "sddc_creds" {
  resource_type = var.resource_type
  account_type  = var.account_type
}

locals {
  credentials_map = { for cred in data.vcf_credentials.sddc_creds.credentials : "${cred.resource[0].name}-${cred.user_name}" => {
    resource_name   = cred.resource[0].name
    resource_type   = cred.resource[0].type
    resource_domain = cred.resource[0].domain
    credential_type = cred.credential_type
    user_name       = cred.user_name
    password        = cred.password
  } }
}

resource "vcf_credentials_rotate" "rotate" {
  for_each      = local.credentials_map
  resource_name = each.value.resource_name
  resource_type = each.value.resource_type
  once_only     = false
  credentials {
    credential_type = each.value.credential_type
    user_name       = each.value.user_name
  }
}

resource "vault_kv_secret_v2" "vault_secrets" {
  for_each = local.credentials_map

  mount               = "vcf"
  name                = "${each.value.resource_name}-${each.value.user_name}"
  cas                 = 1
  delete_all_versions = true

  data_json = jsonencode({
    username = each.value.user_name,
    password = each.value.password, # Replace with the actual rotated password
  })

  custom_metadata {
    max_versions = 100
    data = {
      category   = "vcf"
      system     = each.value.resource_name
      type       = each.value.credential_type
      vcf_domain = each.value.resource_domain
    }
  }
  depends_on = [
    vcf_credentials_rotate.rotate
  ]

}


output "resource_type" {
  value = data.vcf_credentials.sddc_creds.resource_type
}


output "account_type" {
  value = data.vcf_credentials.sddc_creds.account_type
}

/*
output "nsx" {
  value = data.vcf_credentials.nsx_creds.credentials[0].resource[0].name
}
*/
