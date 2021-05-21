// Cloud Storage Bucket
// The solution requires a publicly available(read only) bucket to serve the static content placed on the ‘public’ directory.
resource "google_storage_bucket" "toggl-track-project-website" {
  name          = "toggl-track-project.com"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["https://toggl-track-project.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}
