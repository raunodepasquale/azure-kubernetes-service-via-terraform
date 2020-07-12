# Azure Kubernetes Service Setup via Terraform

## Current status

The current version has been tested as fully functional, please feel free to report any issue you may find.

## Description

Setup with modules, one for a standard AKS with no Azure AD integration, one (the one used in the terraform-main.tf) with RBAC integrated with Azure AD.

The Service Principal to be used for the setup with Azure AD must have Global Admin rights to create applications and assign rights and delegations. If you do not have this level of rights on your Azure Tenant, please use the AKS without AD integration (default in the terraform-main.tf file as for latest versions in this repo).

The cluster is completed with the setup of the ingress controller and cert-manager and with two cluster issuers, both configured for HTTP validation, one using Let's Encrypt production and one using Let's Encrypt staging.

Ingress-controller is configured via Terraform Kubernetes provider.

Cert-Manager and ClusterIssuers via Terraform Helm provider, to demonstrate a different approach.

In order to use this project you will need to replace the two ".sample" files with actual files with the values for your environment in order to have a backend (not mandatory but recommended to store state on a shared and persistent location) and to have the value of the variables for the connection to Azure subscription (and the email to be used for the certificate issuers).

## NOTE

Do not upgrade Azuread provider with newer versions, the setup is tested with the version explicitly selected in the provider file.

## TO DO 

Add a sample web application on a dedicated namespace with DNS name registration on Cloudflare DNS and Certificate provisioning via Cert-Manager and Ingress definition. 

Extract the creation of the Azure AD Applications used for the AD integration into a separate module, to allow creation of AD Integrated AKS instances for users not having Global Admin rights on the Azure Tenant but having the applications already registered by their own Admin.