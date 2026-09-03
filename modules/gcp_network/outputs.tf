output "network_name" {
  value       = google_compute_network.vpc_network.name
  description = "Name of the created VPC network"
}

output "instance_public_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "Public IP address of the Compute instance"
}
