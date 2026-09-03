terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "dev_network" {
  source      = "../../modules/gcp_network"
  project_id  = var.project_id
  region      = var.region
  env         = "dev"
  subnet_cidr = "10.0.10.0/24"
}

output "dev_vm_public_ip" {
  value = module.dev_network.instance_public_ip
}
