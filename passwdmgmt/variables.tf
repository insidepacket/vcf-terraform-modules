variable "sddc_manager_username" {
  description = "Username used to authenticate against an SDDC Manager instance"
  type        = string
}

variable "sddc_manager_password" {
  description = "Password used to authenticate against an SDDC Manager instance"
  type        = string
  sensitive   = true
}

variable "sddc_manager_host" {
  description = "Fully qualified domain name of an SDDC Manager instance"
  default     = "sfo-vcf01.sfo.rainpole.io"
  type        = string
}

variable "vcf_domain_id" {
  description = "Id of the domain for whose resources CSRs are to be generated"
  default     = "sfo-w01"
  type        = string
}

variable "resource_type" {
  description = "The type of the resource. One among ESXI, VCENTER, PSC, NSX_MANAGER, NSX_CONTROLLER, NSX_EDGE, NSXT_MANAGER, VRLI, VROPS, VRA, WSA, VRSLCM, NSX_ALB, BACKUP"
  type        = string
  default     = "ESXI"
}

variable "account_type" {
  description = "The type(s) of the account.One among USER, SYSTEM, SERVICE"
  type        = string
  default     = "USER"
}
