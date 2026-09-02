output "resource_group_ids" {
  description = "Map of created resource group IDs."
  value       = module.resource_group.resource_group_ids
}

output "virtual_network_ids" {
  description = "Map of virtual network IDs."
  value       = { for key, value in module.virtual_network : key => value.virtual_network_id }
}

output "subnet_ids" {
  description = "Map of subnet IDs."
  value       = { for key, value in module.subnet : key => value.subnet_id }
}

output "public_ip_addresses" {
  description = "Map of public IP addresses."
  value       = { for key, value in module.public_ip : key => value.public_ip_address }
}

output "vm_private_ips" {
  description = "Map of VM private IP addresses."
  value       = { for key, value in module.linux_virtual_machine : key => value.private_ip_address }
}
