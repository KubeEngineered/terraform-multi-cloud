# Output the GCS Bucket URL
output "gcs_bucket_url" {
  description = "The URL of the created Google Cloud Storage bucket"
  value       = google_storage_bucket.demo_bucket.url
}

# Output the VM Instance Name
output "instance_name" {
  description = "The name of the Compute Engine instance"
  value       = google_compute_instance.vm_instance.name
}

# Output the VM Public IP address
output "instance_public_ip" {
  description = "The public IP address assigned to the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
