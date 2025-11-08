resource "tfe_organization" "this" {
  name  = var.name
  email = var.email
  session_timeout_minutes = 60 # following security best practices
  session_remember_minutes = 480 # following security best practices
  cost_estimation_enabled = false # cost estimation disabled by default
}

resource "tfe_organization_default_settings" "this" {
  organization           = tfe_organization.this.name
  default_execution_mode = "local" # execution mode: local (storage only)
}

# import {
#   to = tfe_organization.this
#   id = "${var.name}"
# }
