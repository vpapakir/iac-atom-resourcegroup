# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.2] - 2025-01-28

### Fixed
- Support inputs and outputs.

## [0.0.1] - 2025-01-28

### Added
- Initial Azure Resource Group atom implementation
- Traffic light CI/CD system with Azure DevOps and GitHub Actions support
- Input validation for resource group names (1-90 chars, alphanumeric + special chars)
- Terraform Cloud integration with `resourcegroup-azure-dev` workspace
- Comprehensive documentation and usage examples
- Centralized pipeline templates integration (v0.0.15)

### Features
- **Resource**: Azure Resource Group provisioning
- **Validation**: Name length and character restrictions per Azure requirements
- **Outputs**: Resource Group ID, name, and location for consumption by other modules
- **Tagging**: Full tagging support for resource organization
- **CI/CD**: Automated testing, validation, and publishing pipeline

### Infrastructure
- Azure DevOps pipeline with centralized templates
- GitHub Actions workflow for cross-platform CI/CD
- Terraform Cloud backend for state management
- Example configuration for testing and reference