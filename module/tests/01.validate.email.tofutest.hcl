run "email_valid" {
  command = plan

  variables {
    name  = "unique-organization-name"
    email = "valid.email@domain.com"
  }

  # Expect the plan to succeed
}

run "email_empty_fails" {
  command = plan

  variables {
    name  = "unique-organization-name"
    email = "" # Empty email to trigger validation
  }

  # Expect the plan to fail due to empty email
  expect_failures = [
    var.email
  ]
}

run "email_invalid_format_fails" {
  command = plan

  variables {
    name  = "unique-organization-name"
    email = "invalid-email-format" # Invalid email to trigger format validation
  }

  # Expect the plan to fail due to invalid email format
  expect_failures = [
    var.email
  ]
}
