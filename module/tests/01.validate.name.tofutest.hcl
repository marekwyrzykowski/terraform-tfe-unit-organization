run "name_valid" {
  command = plan

  variables {
    name  = "unique-organization-name"
    email = "valid.email@domain.com"
  }

  # Expect the plan to succeed
}

run "name_empty_fails" {
  command = plan

  variables {
    name  = "" # Empty name to trigger validation
    email = "valid.email@domain.com"
  }

  # Expect the plan to fail due to an empty organization name
  expect_failures = [
    var.name
  ]
}
