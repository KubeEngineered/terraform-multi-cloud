# 1. Terraform Settings & Required Providers
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# 2. Variable Definitions
variable "gcp_project_id" {
  type        = string
  default     = "ms-solutionist"
  description = "Your GCP Project ID"
}

variable "gcp_region" {
  type        = string
  default     = "asia-south1"
  description = "Target GCP Region"
}

variable "gcp_zone" {
  type        = string
  default     = "asia-south1-a"
  description = "Target GCP Zone"
}

# 3. Provider Configuration
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# 4. Compute Engine VM Instance Declaration
resource "google_compute_instance" "vm_instance" {
  name         = "demo-vm-instance"
  machine_type = "e2-micro" # Free-tier eligible / cheap testing size

  # Boot Disk Configuration
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  # Network Interface (Attaching to default VPC & granting a Public IP)
  network_interface {
    network = "default"

    # Including access_config block assigns an Ephemeral Public IP
    access_config {}
  }

  # Labels / Metadata for organization
  labels = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

# 5. Output values
output "instance_public_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "The public IP address assigned to the VM instance"
}
