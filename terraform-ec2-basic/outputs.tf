output "instance_id" {
  description = "Server instance id"
  value       = aws_instance.my_server.id
}

output "public_ip" {
  description = "Server public IP address"
  value       = aws_instance.my_server.public_ip
}
