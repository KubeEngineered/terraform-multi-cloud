variable "network_name" {
type        = string
description = "Name of the virtual network"
}


variable "subnet_name" {
type        = string
description = "Name of the subnetwork"
}

variable "subnet_cidr" {
type        = string
description = "CIDR range for the network"
}

variable "region" {
type        = string
description = "GCP region for deploying resource"
default     = "us-central1"
}
