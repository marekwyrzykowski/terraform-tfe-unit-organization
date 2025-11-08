# tests/setup/main.tf
resource "random_pet" "this" {
  length = 2
}

output "unique_name" {
  value = "test-org-${random_pet.this.id}"
}