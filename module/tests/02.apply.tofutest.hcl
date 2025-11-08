run "generate_suffix" {
  # Include the setup module to generate a unique suffix
  module {
    source = "./tests/setup"
  }
  command = apply
}

run "create_organization" {
  command = apply

  variables {
    # Unique name generated for this test run
    name  = run.generate_suffix.unique_name
    email = "valid.email@domain.com"
  }
  assert {
    # Verify that the organization was created successfully
    condition     = tfe_organization.this.name == var.name
    error_message = "Organization '${var.name}' was not created."
  }
}

run "check_organization_email" {
  command = apply

  variables {
    name  = run.generate_suffix.unique_name
    email = "valid.email@domain.com"
  }
  assert {
    # Verify that the organization's email matches the input
    condition     = tfe_organization.this.email == var.email
    error_message = "Organization email does not match input: expected '${var.email}', got '${tfe_organization.this.email}'."
  }
}

run "check_default_settings_reference" {
  command = apply

  variables {
    name  = run.generate_suffix.unique_name
    email = "valid.email@domain.com"
  }
  assert {
    # Verify that the organization default settings reference the organization
    condition     = tfe_organization_default_settings.this.organization == tfe_organization.this.name
    error_message = "Default settings do not reference organization '${tfe_organization.this.name}'."
  }
}

run "check_default_execution_mode" {
  command = apply

  variables {
    name  = run.generate_suffix.unique_name
    email = "valid.email@domain.com"
  }
  assert {
    # Verify that the default execution mode is set to "local"
    condition     = tfe_organization_default_settings.this.default_execution_mode == "local"
    error_message = "Default execution mode for organization '${tfe_organization.this.name}' is not 'local'."
  }
}

run "check_output_token" {
  command = apply

  variables {
    name  = run.generate_suffix.unique_name
    email = "valid.email@domain.com"
  }
  assert {
    # Verify that the output token is set
    condition     = tfe_organization_token.this.token != ""
    error_message = "Output token for organization '${tfe_organization.this.name}' is empty."
  }
}
