include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../module"
}

inputs = {
  name  = values.name
  email = values.email
}
