# Create the storage bucjet for the static content

resource "google_storage_bucket" "static" {
  project = var.project

  name          = "${var.name}-bucket-1234567"
  location      = var.static_content_bucket_location
  storage_class = "MULTI_REGIONAL"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  # For the example, we want to clean up all resources. In production, you should set this to false to prevent
  # accidental loss of data
  force_destroy = true

  labels = var.custom_labels
}

# Upload static content with public read access

resource "google_storage_default_object_acl" "website_acl" {
  bucket      = google_storage_bucket.static.name
  role_entity = ["READER:allUsers"]
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "../app/public/index.html"
  bucket = google_storage_bucket.static.name

  # We have to depend on the ACL because otherwise the ACL could get created after the object
  depends_on = [google_storage_default_object_acl.website_acl]
}

resource "google_storage_bucket_object" "js" {
  name   = "main.js"
  source = "../app/public/main.js"
  bucket = google_storage_bucket.static.name

  # We have to depend on the ACL because otherwise the ACL could get created after the object
  depends_on = [google_storage_default_object_acl.website_acl]
}

resource "google_storage_bucket_object" "not_found" {
  name    = "404.html"
  content = "Uh oh"
  bucket  = google_storage_bucket.static.name

  # We have to depend on the ACL because otherwise the ACL could get created after the object
  depends_on = [google_storage_default_object_acl.website_acl]
}
