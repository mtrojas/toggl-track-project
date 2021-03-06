
# Required parameters

variable "project" {
  default     = "toggl-track-project"
  description = "The project ID to create the resources in."
  type        = string
}

variable "region" {
  default     = "us-west1"
  description = "The region to create the resources in."
  type        = string
}

variable "zone" {
  default     = "us-west1-b"
  description = "The availability zone to create the sample compute instances in. Must be within the region specified in 'var.region'"
  type        = string
}

# Optional parameters

variable "name" {
  description = "Name for the load balancer forwarding rule and prefix for supporting resources."
  type        = string
  default     = "http-multi-backend"
}

variable "enable_ssl" {
  description = "Set to true to enable ssl. If set to 'true', you will also have to provide 'var.custom_domain_name'."
  type        = bool
  default     = true
}

variable "enable_http" {
  description = "Set to true to enable plain http. Note that disabling http does not force SSL and/or redirect HTTP traffic. See https://issuetracker.google.com/issues/35904733"
  type        = bool
  default     = true
}

variable "static_content_bucket_location" {
  description = "Location of the bucket that will store the static content. Once a bucket has been created, its location can't be changed. See https://cloud.google.com/storage/docs/bucket-locations"
  type        = string
  default     = "US"
}

variable "create_dns_entry" {
  description = "If set to true, create a DNS A Record in Cloud DNS for the domain specified in 'custom_domain_name'."
  type        = bool
  default     = true
}

variable "custom_domain_name" {
  description = "Custom domain name."
  type        = string
  default     = "toggl-track-project.com"
}

variable "dns_managed_zone_name" {
  description = "The name of the Cloud DNS Managed Zone in which to create the DNS A Record specified in var.custom_domain_name. Only used if var.create_dns_entry is true."
  type        = string
  default     = "toggl-track-project-com"
}

variable "dns_record_ttl" {
  description = "The time-to-live for the load balancer A record (seconds)"
  type        = string
  default     = 60
}

variable "custom_labels" {
  description = "A map of custom labels to apply to the resources. The key is the label name and the value is the label value."
  type        = map(string)

  default = {}
}
