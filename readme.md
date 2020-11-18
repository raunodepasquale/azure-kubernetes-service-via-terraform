# Azure Kubernetes Service Setup via Terraform

## Current status

The current version has been tested as fully functional, please feel free to report any issue you may find. 

## Pre-Requisites

Terraform version 0.13 and AZ Cli are required to execute the template. 
An Azure tenant and an Azure subscription are required as a Cloudflare DNS. 

## Changes from Release 0.1.0

Compared with Release 0.1.0 we have updated all the providers and the AKS definition, adding scaling rules, IP filtering on access to API and unified the setup to one AKS module only, using the managed identity to integrate authentication with Azure AD, removing the need for a specific module and for the creation of a server and client application in Azure AD to manage the authentication. 
CertManager has also been upgraded to version 1. 
Ingress controller updated and moved from HCL with Kubernetes provider to Helm. 
A test application, with a vanilla setup of Prestashop has been added, with DNS name registration with Cloudflare, has been added to demonstrate application deployment and usage of ingress controller and cert-manager to have https access with a valid certificate. 
Authentication for the Kubernetes provider has been changed to avoid authentication errors due to the usage of Azure AD. 

## How to use it

Release 0.2.0 with the tests completed for the creation of the cluster, with ingress controller, cert-manager and cluster issuers for HTTP validation of Let's Encrypt certificates.  

To use it: 

get a local copy of the repo, select or create a service principal with at least the contributor role in the target subscription. Copy the file terraform.tfvars.sample into terraform.tfvars and replace the values with the correct one for your setup. 

It is also recommended, but not mandatory, to copy terraform-backend.tf.sample in terraform-backend.tf and replace the values with the one of a storage created to host the state file. 

Check the values in variables-aks.tf; variables-networks.tf; variables-project.tf in the root folder and correct if and where required for your specific needs. 
Position in the root folder of the repo and execute: 

terraform init 

terraform validate 

terraform plan -out=plan 

terraform apply "plan"  


Please check the output of each command to verify issues or errors. 

## Description

Setup with modules, to setup AKS with Azure AD integration. 

The cluster is completed with the setup of the ingress controller and cert-manager and with two cluster issuers, both configured for HTTP validation, one using Let's Encrypt production and one using Let's Encrypt staging. 

Ingress-controller is configured via Terraform Kubernetes provider. 

Cert-Manager and ClusterIssuers via Terraform Helm provider, to demonstrate a different approach. 

In order to use this project you will need to replace the two ".sample" files with actual files with the values for your environment in order to have a backend (not mandatory but recommended to store state on a shared and persistent location) and to have the value of the variables for the connection to Azure subscription (and the email to be used for the certificate issuers). 
