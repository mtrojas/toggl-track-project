variable "region" {
  default     = "us-east1"
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

variable "name" {
  default     = "toggl-track-db"
  description = "The name of the Cloud SQL resources"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}






