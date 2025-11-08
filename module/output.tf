output "name" {
  value       = tfe_organization.this.name
  description = "The organization's name."
}

output "token" {
  sensitive   = true
  value       = tfe_organization_token.this.token
  description = "The organization's API token for managing the organization."
}
