# Create the Load Balancer

module "lb" {
  source                = "gruntwork-io/load-balancer/google//modules/http-load-balancer"
  name                  = var.name
  project               = var.project
  url_map               = google_compute_url_map.urlmap.self_link
  dns_managed_zone_name = var.dns_managed_zone_name
  custom_domain_names   = [var.custom_domain_name]
  create_dns_entries    = var.create_dns_entry
  dns_record_ttl        = var.dns_record_ttl
  enable_http           = var.enable_http
  enable_ssl            = var.enable_ssl
  ssl_certificates      = google_compute_ssl_certificate.certificate.*.self_link

  custom_labels = var.custom_labels
}

# Create the URL map to map paths to backends

resource "google_compute_url_map" "urlmap" {
  project = var.project

  name        = "${var.name}-url-map"
  description = "URL map for ${var.name}"

  default_service = google_compute_backend_bucket.static.self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "all"
  }

  path_matcher {
    name            = "all"
    default_service = google_compute_backend_bucket.static.self_link

    path_rule {
      paths   = ["/api", "/api/*"]
      service = google_compute_backend_service.api.self_link
    }
  }
}

# Create the backend service configuration for the instance group

resource "google_compute_backend_service" "api" {
  project = var.project

  name        = "${var.name}-api"
  description = "API Backend for ${var.name}"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = google_compute_instance_group.api.self_link
  }

  health_checks = [google_compute_health_check.default.self_link]

  depends_on = [google_compute_instance_group.api]
}

# Create the backend service configuration for the storage bucket

resource "google_compute_backend_bucket" "static" {
  project = var.project

  name        = "${var.name}-backend-bucket"
  bucket_name = google_storage_bucket.static.name
  enable_cdn  = true
}

# If SSL is enabled, create a self-signed certificate

resource "tls_self_signed_cert" "cert" {
  # Only create if SSL is enabled
  count = var.enable_ssl ? 1 : 0

  key_algorithm   = "RSA"
  private_key_pem = join("", tls_private_key.private_key.*.private_key_pem)

  subject {
    common_name  = var.custom_domain_name
    organization = "Examples, Inc"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "tls_private_key" "private_key" {
  count       = var.enable_ssl ? 1 : 0
  algorithm   = "RSA"
  ecdsa_curve = "P256"
}

# Create a corresponding Google Certificate that we can attach to the Load Balancer

resource "google_compute_ssl_certificate" "certificate" {
  project = var.project

  count = var.enable_ssl ? 1 : 0

  name_prefix = var.name
  description = "SSL Certificate"
  private_key = join("", tls_private_key.private_key.*.private_key_pem)
  certificate = join("", tls_self_signed_cert.cert.*.cert_pem)

  lifecycle {
    create_before_destroy = true
  }
}





