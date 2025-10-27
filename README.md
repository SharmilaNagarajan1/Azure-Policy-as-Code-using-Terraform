# Azure Policy CI/CD

## Overview
This repository contains a Terraform module and GitHub Actions workflow to implement **Azure Policy as Code**. The policy restricts the creation of Azure resources to the **East US** region. The workflow automatically validates and deploys the policy whenever changes are made to the module.

---

## Features
- Create a **custom Azure Policy** that allows resources only in East US.
- Assign the policy to the current subscription.
- Implement CI/CD using **GitHub Actions** for automatic validation and deployment.
- Terraform Cloud integration for state management.

---

## Prerequisites
1. **Azure Subscription** with permissions to create policies.
2. **Terraform Cloud** account and workspace.
3. **GitHub Repository** for the workflow.
4. **GitHub Secrets** configured:
   - `AZURE_CLIENT_ID`
   - `AZURE_CLIENT_SECRET`
   - `AZURE_SUBSCRIPTION_ID`
   - `AZURE_TENANT_ID`
   - `TF_API_TOKEN` (Terraform Cloud API token)

---

## Repository Structure
```bash
.
├── policy-module/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── .github/
│ └── workflows/azure-policy-ci.yml
└── README.md
```
---

- `policy-module/` – Contains Terraform code for policy definition and assignment.
- `azure-policy-cicd.yml` – GitHub Actions workflow to validate and deploy the policy.

## GitHub Actions Workflow
- **Triggered on:** `push` and `pull_request` events to the `main` branch  
- **Runs only when:** changes are made in `policy-module/**`  

### Steps:
1. **Checkout repository** – Pulls the latest code from GitHub.  
2. **Set up Terraform CLI** – Installs Terraform and configures credentials.  
3. **terraform init** – Initializes the Terraform working directory.  
4. **terraform validate** – Validates the Terraform configuration.  
5. **terraform plan** – Creates an execution plan to show changes.  
6. **terraform apply** – Applies the changes (only on push to `main`).  

---

## Policy Details
- **Name:** deny-non-east-us-locations  
- **Type:** Custom  
- **Mode:** All  
- **Effect:** Deny resource creation outside `East US`  
- **Assignment:** Applied to the current subscription  

---

## Notes
- Using **Policy as Code** ensures version control, automated compliance, and collaboration through pull requests.  
- **Terraform Cloud** manages state securely and allows multiple contributors without conflicts.  
- `continue-on-error: true` for `terraform plan` ensures the workflow does not fail on planned errors but still validates the code.  

---

## References
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)  
- [Azure Policy Documentation](https://learn.microsoft.com/en-us/azure/governance/policy/overview)  
- [GitHub Actions for Terraform](https://github.com/hashicorp/setup-terraform)  
