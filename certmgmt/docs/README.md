# HowTO

## Function
This module can be used to renew vCenter and NSX certificates (including NSX Cluster and NSX Manager node certificates) in a VMware Cloud Foundation workload domain.

## Prerequisites

* You have either MSFT CA or OpenSSL CA configured in the SDDC Manager
* The domain ID of the Workload domain. You can retrieve the domain Id via a GET API: https://{{baseUrl}}/v1/domains

## Constraints
As VMware Cloud Foundation SDDC Manager only allow one certificate operation at a time. Using `-parallelism=1` is required when running `terraform apply`. 