// PostgreSQL Database -> Cloud SQL
// The solution requires a single PostgreSQL instance running on 9.6(or newer). Feel free to choose between provisioning it in Compute Engine(Use the Linux distribution of your choice) or Cloud SQL.
// The API requires a database and a user. However, it creates all required tables internally. If Compute Engine is chosen don’t forget to register it in Consul and add a health check.

data "google_compute_zones" "available" {
}

module "sql-db_postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "5.0.1"
  count   = length(data.google_compute_zones.available.names)

  name             = var.name
  database_version = var.database_version
  project_id       = var.project
  zone             = data.google_compute_zones.available.names[count.index]
  db_name          = "toggltrack"
  user_name        = "toggl"
}


