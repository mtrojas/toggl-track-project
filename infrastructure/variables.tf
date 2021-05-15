variable "region" {
  default     = "southamerica-east1"
  description = "The region for subnetworks in the network"
  type        = string
}

variable "project" {
  default     = "toggl-track-project"
  description = "The project ID for the network"
  type        = string
}

variable "name_prefix" {
  default     = "vpc"
  description = "A name prefix used in resource names to ensure uniqueness across a project."
  type        = string
}



