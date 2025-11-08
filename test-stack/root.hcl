generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

provider "tfe" {
  hostname = "app.terraform.io"
  token    = "${yamldecode(file(find_in_parent_folders("dev.secrets.yaml"))).tfe.token}"
}
EOF

}


generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "${yamldecode(file(find_in_parent_folders("dev.secrets.yaml"))).organization}"
    token        = "${yamldecode(file(find_in_parent_folders("dev.secrets.yaml"))).tfe.backend.token}"
    workspaces {
      name = "${md5(path_relative_to_include())}"
    }
  }
  encryption {
    key_provider "pbkdf2" "mypass" {
      passphrase = "${yamldecode(file(find_in_parent_folders("dev.secrets.yaml"))).tfe.backend.token}"
    }
    method "aes_gcm" "myencryption" {
      keys = key_provider.pbkdf2.mypass
    }
    state {
      method = method.aes_gcm.myencryption
    }
  }
}
EOF

}

terraform {
  # copy the state from local to consul backend or from consul to local backend
  extra_arguments "init_options" {
    commands  = ["init"]
    arguments = ["-ignore-remote-version"]
  }
}