# terraform-tfe-unit-organization

A Terragrunt-friendly Terraform module that creates and configures an organization in Terraform Enterprise (TFE) or Terraform Cloud (TFC).

## Overview
This module provisions a TFE/TFC organization with sensible defaults, validates input variables, and exposes the organization's API token as a sensitive output. It includes unit tests to verify input validation and basic provisioning behavior.

## Requirements
- A TFE/TFC account with permissions to create organizations.
- A valid TFE/TFC API token available in the environment or CI secrets.
- The `hashicorp/tfe` provider configured where the module is used.

## Inputs
- `name` (string) — Unique name of the organization to create. Must be non-empty.
- `email` (string) — Email address associated with the organization. Must be non-empty and a valid email format.

## Outputs
- `name` — The created organization's name.
- `token` — The organization's API token (marked as sensitive). Use this token for automating workspace creation and CI integrations.

## Usage
Include the module in your Terragrunt or Terraform configuration and provide the required variables. Ensure the TFE provider has access to an API token (for example via environment variable or TF_VAR).

Example (Terragrunt/Terraform):
- Set `source` to this module and provide `name` and `email`.
- Ensure the TFE provider token is available in CI (do not commit tokens to the repository).

A simple example configuration is provided in the [test-stack](test-stack) folder of this repository.

## Tests
Unit tests are provided under `module/tests/`:
- `01.validate.name.tofutest.hcl` — validates `name` variable behavior.
- `01.validate.email.tofutest.hcl` — validates `email` variable behavior.
- `02.apply.tofutest.hcl` — applies the module and verifies organization creation, email assignment, default settings, and token output.
- `tests/setup` — helper used by tests to generate unique names.

Run tests in a safe environment and provide the required API token as a secret.

## License
[MPL-2.0](LICENSE)
