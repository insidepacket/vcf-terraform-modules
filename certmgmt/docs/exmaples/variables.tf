variable "sddc_manager_username" {
  description = "Username used to authenticate against an SDDC Manager instance"
  default     = "administrator@vsphere.local"
  type        = string
}

variable "sddc_manager_password" {
  description = "Password used to authenticate against an SDDC Manager instance"
  default     = "VMw@re1!"
  sensitive   = true
}

variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
  default     = "sfo-vcf01.sfo.rainpole.io"
  type        = string
}

variable "vcf_domain_id" {
  description = "Id of the domain for whose resources CSRs are to be generated"
  default     = "1f6d229e-1218-4033-b1cc-f0efa390d512"
  type        = string
}


variable "ca_secret" {
  description = "Password used to authenticate against MSFT CA"
  default     = "VMw@re1!"
  sensitive   = true
}

variable "cert_country" {
  description = "country in the cert"
  default     = "US"
  type        = string
}

variable "cert_locality" {
  description = "locality in the cert"
  default     = "Palo Alto"
}

variable "cert_email" {
  description = "email in the cert"
  default     = "admin@vmware.com"
  type        = string
}

variable "cert_key_size" {
  description = "keysize in the cert"
  default     = "3072"
  type        = string
}

variable "cert_organization" {
  description = "organization in the cert"
  default     = "VMware Inc."
  type        = string
}

variable "cert_organization_unit" {
  description = "organization_unit in the cert"
  default     = "VCF"
  type        = string
}

variable "cert_state" {
  description = "state in the cert"
  default     = "CA"
  type        = string
}

variable "ca_server_url" {
  description = "ca server url in the cert"
  default     = "https://rpl-ad01.rainpole.io/certsrv"
  type        = string
}

variable "ca_template_name" {
  description = "cert template name"
  default     = "VMware"
  type        = string
}
