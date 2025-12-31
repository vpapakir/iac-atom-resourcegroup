# iac-atom-resourcegroup

A cloud-specific Terraform atom for provisioning Azure Resource Groups as part of an atom-molecule-template infrastructure architecture.

## Traffic Light System

This repository implements a **traffic light system** for CI/CD pipeline control using structured commit messages. Since Azure Resource Groups are Azure-specific, only Azure-related CI tools are supported.

### Commit Message Convention

All commit messages must follow this format:
```
[repo] [cloud] [ci-tool] [action] <description>
```

**Components:**
- `[repo]`: Repository platform - `[github]`
- `[cloud]`: Target cloud provider - `[azure]` (only)
- `[ci-tool]`: CI/CD platform - `[ado]`, `[gh_actions]`
- `[action]`: Pipeline action - `[build]`, `[release]`

**Examples:**
```bash
# Build and validate Azure Resource Group using Azure DevOps
git commit -m "[github] [azure] [ado] [build] fix: update resource group naming"

# Build and validate using GitHub Actions
git commit -m "[github] [azure] [gh_actions] [build] feat: add validation rules"

# Create release PR using Azure DevOps
git commit -m "[github] [azure] [ado] [release] feat: ready for release"
```

### Pipeline Execution Matrix

| Commit Message | Azure DevOps | GitHub Actions |
|---|---|---|
| `[github] [azure] [ado] [build]` | ✅ Run | ❌ Skip |
| `[github] [azure] [gh_actions] [release]` | ❌ Skip | ✅ Run |

## Architecture Overview

This repository follows the **atom-molecule-template** design pattern:

- **Atoms**: Individual infrastructure components (this Resource Group atom)
- **Molecules**: Compositions of atoms that create functional units
- **Templates**: Complete application stacks that consume molecules

## Current Implementation

### Azure Resource Group (`iac/terraform/azure/`)
- **Resource**: Azure Resource Group
- **Features**: Name validation, location specification, tagging support
- **Validation**: Name length (1-90 chars) and character restrictions
- **State**: Terraform Cloud workspace (`resourcegroup-azure-dev`)
- **Outputs**: Resource Group ID, name, and location

### Module Structure
- `main.tf` - Core Resource Group resource definition
- `variables.tf` - Input parameters with validation rules
- `outputs.tf` - Exposed values for consumption
- `backend.tf` - Terraform Cloud configuration
- `versions.tf` - Terraform version constraints

## Usage

### Module Publication
Modules are automatically published to Terraform Cloud and referenced by URI:

```hcl
module "resource_group" {
  source  = "app.terraform.io/vpapakir/resourcegroup/azure"
  version = "~> 1.0"
  
  name     = "rg-myapp-dev"
  location = "East US"
  
  tags = {
    Environment = "dev"
    Project     = "myapp"
    ManagedBy   = "terraform"
  }
}
```

### Release Workflow

#### 1. Development
```bash
git commit -m "[github] [azure] [ado] [build] feat: add resource group validation"
git push origin feature-branch
```
- Runs validation on Azure Resource Group module
- Tests example configuration

#### 2. Release Intent
```bash
git commit -m "[github] [azure] [ado] [release] feat: ready for release"
git push origin feature-branch
```
- Creates automated PR to main branch
- Requires team review and approval

#### 3. Automatic Publication
- Reviewer approves PR with version message
- PR merge triggers pipeline on main branch
- Publishes versioned module to Terraform Cloud

## Pipeline Configuration

### Centralized Pipeline Templates
Pipeline templates are sourced from the centralized `iac-pipeline-templates` repository:
- **Template Repository**: https://github.com/vpapakir/iac-pipeline-templates
- **Current Version**: `v0.0.15`
- **Azure-Specific**: Only Azure DevOps and GitHub Actions supported

### Azure DevOps (`.azure/pipeline.yml`)
- **Template**: `azure/stages/traffic-light-pipeline.yml@templates`
- **Version**: `v0.0.15`
- **Variable Groups**: `terraform` (TF_CLOUD_TOKEN), `shared` (GITHUB_TOKEN, Azure credentials)
- **Stages**: CommitCheck → Build → CreatePR → Publish

### GitHub Actions (`.github/workflows/pipeline.yml`)
- **Workflow**: `vpapakir/iac-pipeline-templates/.github/workflows/traffic-light-pipeline.yml@v0.0.15`
- **Secrets**: `TF_CLOUD_TOKEN`, `GITHUB_TOKEN`
- **Jobs**: commit-check → build → create-pr → publish

## Repository Structure

```
iac-atom-resourcegroup/
├── .azure/                    # Azure DevOps pipeline definitions
│   └── pipeline.yml           # Main pipeline using centralized templates
├── .github/                   # GitHub Actions workflows
│   └── workflows/
│       └── pipeline.yml       # Traffic light pipeline
├── examples/                  # Pipeline testing examples
│   └── azure-example/         # Azure Resource Group usage example
├── iac/
│   └── terraform/
│       └── azure/             # Azure Resource Group module
├── .gitignore
├── LICENSE
└── README.md
```

## Contributing

This atom implements the **traffic light system** for clean CI/CD pipeline control:

1. **Follow commit message convention** - Use `[github] [azure] [ci-tool] [action]` format
2. **Azure-specific only** - Only `[azure]` cloud provider supported
3. **Use build for development** - Validate changes with `[build]` action
4. **Use release for PR creation** - Create PRs with `[release]` action
5. **Control module publishing** - Choose CI tool in PR approval message

### Quick Reference

```bash
# Development testing
git commit -m "[github] [azure] [ado] [build] fix: update resource group validation"

# Ready for release
git commit -m "[github] [azure] [gh_actions] [release] feat: new resource group features"

# PR approval (in GitHub PR comment)
"[APPROVED] [MINOR] [gh_actions] new features look good"
```

## License

See [LICENSE](LICENSE) file for details.
This is a reusable and consumable terraform atom to provision resource groups in azure
