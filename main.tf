# 1. Terraform Settings & Required Providers
terraform {
  required_version = ">= 1.5.0"

  backend "gcs" {
    bucket = "devops-demo-bucket-dev"
    prefix = "terraform/state/dev"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}


# 2. Variable Definitions
# variable "gcp_project_id" {
# type        = string
# default     = "ms-solutionist"
# description = "Your GCP Project ID"
#}

# variable "gcp_region" {
# type        = string
# default     = "asia-south1"
# description = "Target GCP Region"
# }

# variable "gcp_zone" {
# type        = string
# default     = "asia-south1-a"
# description = "Target GCP Zone"
#}


# 3. Provider Configuration
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}


# 4. Compute Engine VM Instance Declaration
resource "google_compute_instance" "vm_instance" {
  name         = "demo-vm-instance"
  machine_type = "e2-micro" # Free-tier eligible / cheap testing size
  zone         = "${var.gcp_region}-a"

  # Boot Disk Configuration
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Network Interface (Attaching to default VPC & granting a Public IP)
  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.custom_subnet.id

    # Including access_config block assigns an Ephemeral Public IP
    access_config {}
  }

  # Labels / Metadata for organization
  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }
}


# 3. Google cloud storage bucket Declaration
resource "google_storage_bucket" "demo_bucket" {
  name                     = "devops-demo-bucket-${var.environment}"
  location                 = "US"
  force_destroy            = true
  public_access_prevention = "enforced"
}



# # Create a custom VPC network

resource "google_compute_network" "custom_vpc" {
  name                    = "devops-vpc-${var.environment}"
  auto_create_subnetworks = false
}

# Create a subnet within VPC

resource "google_compute_subnetwork" "custom_subnet" {
  name          = "devops-subnet-${var.environment}"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.custom_vpc.id
}

# Allow SSH and Port 8080 traffic
resource "google_compute_firewall" "allow_app_traffic" {
  name    = "allow-app-traffic-${var.environment}"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}
