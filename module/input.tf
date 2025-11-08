variable "name" {
  type        = string
  description = "The name must be unique across all TFE organizations."
  validation {
    condition     = length(var.name) > 0
    error_message = "Organization name cannot be empty."
  }
}

variable "email" {
  type        = string
  description = "The email address associated with the organization."

  # Email cannot be empty
  validation {
    condition     = length(var.email) > 0
    error_message = "The email address cannot be empty."
  }

  # Email must be in a valid format
  validation {
    condition     = can(regex("^\\S+@\\S+\\.\\S+$", var.email))
    error_message = "The email address must be in a valid format."
  }
}
