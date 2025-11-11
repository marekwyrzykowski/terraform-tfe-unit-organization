include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "github.com/marekwyrzykowski/terraform-tfe-unit-organization.git//module/?ref=${values.version}"
}

inputs = {
  name  = values.name
  email = values.email
}
