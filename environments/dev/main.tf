terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "ms-solutionist"
  region  = "us-central1"
}

module "dev_vpc" {
  source = "../../modules/gcp_network"

  network_name = "dev-vpc"
  subnet_name  = "dev-subnet-01"
  subnet_cidr  = "10.10.0.0/24"
  region       = "us-central1"
}

output "dev_network_id" {
  value = module.dev_vpc.network_id
}
