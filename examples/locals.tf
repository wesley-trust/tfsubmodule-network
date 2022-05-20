# Calculate local variables
locals {

  # Service functions and concatenations
  service_location_prefix    = replace(var.service_location, "/[a-z[:space:]]/", "")

}