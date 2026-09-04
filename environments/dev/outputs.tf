output "vm_public_ip" {
  value       = module.dev_vm.instance_ip
  description = "Public IP of the Dev App Server"
}
