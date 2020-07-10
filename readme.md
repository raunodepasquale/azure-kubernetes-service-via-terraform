# Azure Kubernetes Service Setup via Terraform

## TO DO 

This is an initial version still to be gone via full testing

## Description

Setup with modules, one for a standard AKS with no Azure AD integration, one (the one used in the terraform-main.tf) with RBAC integrated with Azure AD.

The Service Principal to be used for the setup with Azure AD must have required rights to create applications and assign rights and delegations.

The cluster is completed with the setup of the ingress controller and cert-manager.

Ingress-controller is configured via Terraform Kubernetes provider.

Cert-Manager via Terraform Helm provider, to demonstrate a different approach.

In order to use this project you will need to replace the two ".sample" files with actual files with the values for your environment.

## NOTE

Do not upgrade Azuread provider with newer versions, the setup is tested with the version explicitly selected in the provider file.