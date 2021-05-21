// PostgreSQL Database -> Cloud SQL
// The solution requires a single PostgreSQL instance running on 9.6(or newer). Feel free to choose between provisioning it in Compute Engine(Use the Linux distribution of your choice) or Cloud SQL.
// The API requires a database and a user. However, it creates all required tables internally. If Compute Engine is chosen don’t forget to register it in Consul and add a health check.
resource "google_sql_database_instance" "db" {
  name             = "postgres-db-instance"
  database_version = "POSTGRES_11"
  region           = var.region
  depends_on       = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.self_link
    }
  }
}

resource "google_sql_user" "toggl-user" {
  name     = "toggl"
  instance = google_sql_database_instance.db.name
  password = var.db_password
}

resource "google_sql_database" "toggl-db" {
  name     = "toggltrack"
  instance = google_sql_database_instance.db.name
}

