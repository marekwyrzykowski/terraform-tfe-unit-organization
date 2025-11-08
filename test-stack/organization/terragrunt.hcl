include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../module"
}

inputs = {
  name  = "marekwyrzykowski-tfe-dev-dev-unit"
  email = "marekwyrzykowski-tesst@gmail.com"
}
