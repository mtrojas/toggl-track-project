provider "google" {
  project = var.project
  region  = var.region
}

// Load Balancer: lb-http module
// https://registry.terraform.io/modules/GoogleCloudPlatform/lb-http/google/latest


// PostgreSQL Database -> Cloud SQL
// The solution requires a single PostgreSQL instance running on 9.6(or newer). Feel free to choose between provisioning it in Compute Engine(Use the Linux distribution of your choice) or Cloud SQL.

// The API requires a database and a user. However, it creates all required tables internally. If Compute Engine is chosen don’t forget to register it in Consul and add a health check.

// API Server(s)
//The solution requires an API Server(s) running on Compute Engine(Use the Linux distribution of your choice). Both the source code and the binary are provided in the ‘api’ directory.

//The binary requires ‘config.json’ file with two values: PostgreSQL connection string (db_connstring) and an HTTP port (http_port). See ‘config.sample.json’ for a sample binary. Configuration should be passed to binary using a --config-file flag.

//Don’t forget to register it in Consul and add a health check.

// Cloud Storage Bucket
// The solution requires a publicly available(read only) bucket to serve the static content placed on the ‘public’ directory.
# resource "google_storage_bucket" "toggl-track-project-website" {
#   name          = "toggl-track-project.com"
#   location      = "US"
#   force_destroy = true

#   uniform_bucket_level_access = true

#   website {
#     main_page_suffix = "index.html"
#     not_found_page   = "404.html"
#   }
#   cors {
#     origin          = ["https://toggl-track-project.com"]
#     method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
#     response_header = ["*"]
#     max_age_seconds = 3600
#   }
# }

// Consul Server(s)
// The solution requires a single(or cluster) Hashicorp Consul, running on Compute Engine(Use the Linux distribution of your choice) for service discovery.
