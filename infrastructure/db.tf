module "sql-db_postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "5.0.1"
  # insert the 6 required variables here
  name             = var.name
  database_version = var.database_version
  project_id       = var.project
  zone             = var.zone
}
