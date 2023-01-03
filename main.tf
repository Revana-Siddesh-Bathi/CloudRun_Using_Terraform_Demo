resource "google_compute_network" "vpc-network" {
  project                 = var.project_id
  name                    = "vpc-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "my_subnetwork" {
  name          = "vpc-subnet"
  ip_cidr_range = "10.2.0.0/28"
  region        = var.region
  network       = google_compute_network.vpc-network.id
}

resource "google_vpc_access_connector" "connector" {
  name          = "vpc-con"
  subnet {
    name = google_compute_subnetwork.my_subnetwork.name
  }
  machine_type = "e2-micro"
}

resource "google_cloud_run_service" "default" {
  provider = google-beta
  name     = "yaml2json-cloudrun-srv"
  location = var.region
  autogenerate_revision_name = true

  template {
    spec {
      containers {
        image = var.container_image
        resources {
          limits = {
            cpu = "${var.cpus * 1000}m"
            memory = "${var.memory}Mi"
          }
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_compute_network.vpc-network]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = var.project_id
  service     = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}