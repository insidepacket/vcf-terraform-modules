# Quick Start

## How does the module help you?
This module can be used to renew vCenter and NSX certificates (including NSX Cluster and NSX Manager node certificates) in a VMware Cloud Foundation workload domain.

## Prerequisites

* You have a MSFT CA (with basic authentication) up and running and the MSFT CA has a template available.
* The domain ID of the Workload domain. You can retrieve the domain Id via a GET API: https://{{baseUrl}}/v1/domains

## What does the modules do?
* Configure your CA in the VMware Cloud Foundation SDDC manager
* Generate Certificate Signing Requests (CSR) based the FQDN of vCenter, NSX and NSX Manager nodes and also get CA signed the CSRs
* Replace the current certificates with new CA signed certificates

## Constraints
As VMware Cloud Foundation SDDC Manager only allow one certificate operation at a time. Using `-parallelism=1` is required when running `terraform apply`: `terraform apply -parallelism=1`

Note: -parallelism=n - Limit the number of concurrent operation as Terraform apply your template. Defaults to 10