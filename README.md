
---

```markdown
# 🌏 Azure Policy as Code – Enforce Allowed Locations with Terraform & GitHub Actions

This repository demonstrates **Policy-as-Code** using **Terraform**, **Terraform Cloud**, and **GitHub Actions** to enforce Azure governance.  
The Terraform configuration defines and assigns a custom **Azure Policy** that restricts resource creation to the **East US** region only.

---

## 🚀 What This Project Does

- 🏗️ Creates a **custom Azure Policy Definition** to deny resources deployed outside `eastus`.
- 🔐 Assigns the policy at **subscription level** using Terraform.
- ☁️ Uses **Terraform Cloud** for remote backend and state management.
- ⚙️ Automates provisioning with a **GitHub Actions CI/CD pipeline**.
- ✅ Enforces region compliance automatically across your Azure environment.

---

## 📁 Repository Structure
.
├── policy-module/
│   ├── main.tf                      # Main Terraform configuration (provider + resources)
│   ├── variables.tf                 # Input variables for policy configuration
│   ├── restrict-region-policy.json  # JSON policy rule
│
└── .github/workflows/
              └── azure-policy-ci.yaml     # CI/CD workflow to deploy policy automatically
```
---

## ⚙️ How It Works

1. The **Terraform code** defines a custom policy named `deny-non-east-us-locations`.  
2. The policy rule denies any resource creation where `"location" != "eastus"`.
3. Terraform assigns this policy at the **subscription level**.
4. The **GitHub Actions pipeline** runs automatically on code changes to plan and apply Terraform.
5. **Terraform Cloud** securely manages the remote state and workspace.

---

## 🧠 Azure Policy Logic

```json
{
  "if": {
    "not": {
      "field": "location",
      "equals": "eastus"
    }
  },
  "then": {
    "effect": "deny"
  }
}
````

If a resource is deployed to any other region (e.g., `westus`), deployment will be **denied** by Azure Policy.

---

## 🏗️ Terraform Cloud Configuration

Terraform uses a **remote backend** stored in Terraform Cloud:

```hcl
cloud {
  organization = "Sharmila"
  workspaces {
    name = "azure-policy-module"
  }
}
```

This enables:

* Centralized state management
* Version control integration
* Visibility into all plan/apply runs

---

## 🔄 CI/CD Workflow (`azure-policy-ci.yaml`)

The GitHub Actions workflow automates policy deployment.

### 🧩 Triggers

Runs when:

* Code is pushed to `main` under `policy-module/**`
* A pull request targets `main` with changes to `policy-module/**`

### 🪜 Steps

1. **Checkout** source code
2. **Setup Terraform** with version and token
3. **Init** Terraform backend
4. **Validate** Terraform configuration
5. **Plan** the changes (dry-run)
6. **Apply** automatically on push to main

---

## 🔐 Required Secrets

Add the following GitHub repository **Actions secrets**:

| Secret Name             | Purpose                           |
| ----------------------- | --------------------------------- |
| `AZURE_CLIENT_ID`       | Azure Service Principal Client ID |
| `AZURE_CLIENT_SECRET`   | Azure Service Principal Secret    |
| `AZURE_TENANT_ID`       | Azure Tenant ID                   |
| `AZURE_SUBSCRIPTION_ID` | Target Azure Subscription         |
| `TF_API_TOKEN`          | Terraform Cloud API token         |

---

## 🧾 Example Terraform Output

```bash
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

policy_definition_id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyDefinitions/deny-non-east-us-locations"
policy_assignment_id = "/subscriptions/<subscription_id>/providers/Microsoft.Authorization/policyAssignments/deny-non-east-us-locations-assignment"
```

---

## 🔍 Verification Steps

1. Open **Azure Portal → Policy → Definitions** and confirm the policy exists.
2. Check **Assignments** to ensure the policy is assigned to your subscription.
3. Try to deploy a resource in another region (e.g., `West US`) — it should **fail**.

---

## 🧰 Prerequisites

Before using this project:

* Azure CLI installed and authenticated
* Azure Service Principal with **Owner / Policy Contributor** role
* Terraform Cloud organization created
* Terraform Cloud workspace named **`azure-policy-module`**
* GitHub Actions secrets configured as above

---

## 🧪 Demo Walkthrough

1. **Show repository structure** and explain each component.
2. **Trigger workflow** by pushing a change.
3. **View GitHub Actions run logs** – watch Terraform init, plan, and apply.
4. **Open Terraform Cloud** – confirm remote state and run details.
5. **Open Azure Portal** – verify the policy and attempt a non-East US deployment (expect denial).

---

## 🔮 Future Enhancements

* Add reusable modules for other policy types (tags, SKUs, resource types).
* Include compliance monitoring using Azure Policy Insights.
* Add self-hosted runners for controlled Terraform execution.
* Integrate Sentinel or GitHub environment approvals for governance.

---

## 📚 Summary

This project delivers a **Policy-as-Code pipeline** that ensures Azure regional compliance using:

* **Terraform** for defining Azure Policy
* **Terraform Cloud** for backend/state management
* **GitHub Actions** for CI/CD automation

✅ **Outcome:** a repeatable, automated, and auditable workflow to enforce organization-wide governance.

---

