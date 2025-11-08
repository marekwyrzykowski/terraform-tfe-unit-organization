resource "tfe_organization_token" "this" {
  organization = tfe_organization.this.name
  force_regenerate = true
}
