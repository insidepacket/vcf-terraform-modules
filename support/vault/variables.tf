variable "vault_address" {
  description = "Hashicorp Vault address"
  type        = string
  default     = "http://10.221.78.150:8200"
}

variable "secrets" {
  type = map(any)
  default = {
    "sfo-m01-en01.sfo.rainpole.io-admin" = {
      "credential_type"  = "API",
      "domain"           = "sfo-m01",
      "last_rotate_time" = "2024-08-16T19:42:27+10:00",
      "password"         = "111",
      "resource_name"    = "sfo-m01-en01.sfo.rainpole.io",
      "resource_type"    = "NSXT_EDGE",
      "secret_id"        = "7a64c016e617fab82c0acaca3adf7324",
      "user_name"        = "admin"
    },
    "sfo-m01-en01.sfo.rainpole.io-audit" = {
      "credential_type"  = "AUDIT",
      "domain"           = "sfo-m01",
      "last_rotate_time" = "2024-08-16T19:43:54+10:00",
      "password"         = "111",
      "resource_name"    = "sfo-m01-en01.sfo.rainpole.io",
      "resource_type"    = "NSXT_EDGE",
      "secret_id"        = "a7be4ac4331df1faebcb82fe53d13193",
      "user_name"        = "audit"
    },
    "sfo-m01-en01.sfo.rainpole.io-root" = {
      "credential_type"  = "SSH",
      "domain"           = "sfo-m01",
      "last_rotate_time" = "2024-08-16T19:44:37+10:00",
      "password"         = "111",
      "resource_name"    = "sfo-m01-en01.sfo.rainpole.io",
      "resource_type"    = "NSXT_EDGE",
      "secret_id"        = "d0d7b4cff077907a4710c797d9ef440c",
      "user_name"        = "root"
    }
  }
}

