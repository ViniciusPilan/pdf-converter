output "stack_name" {
  value = aws_instance.main_server.tags.Stack
}

output "instance_id" {
  value = aws_instance.main_server.id
}

output "instance_private_ipv4" {
  value = aws_instance.main_server.private_ip
}

output "instance_public_ipv4" {
  value = aws_instance.main_server.public_ip
}

output "instance_public_dns" {
  value = aws_instance.main_server.public_dns
}

output "instance_public_elastic_ip" {
  value = aws_eip.main_server_ip.public_ip
}

output "instance_url_for_ssh" {
  # value = "ssh -i " + aws_key_pair.remote_access.key_name + ".pem ubuntu@" + aws_eip.main_server_ip.public_ip
  value = format("ssh -i '/root/.ssh/%s' ubuntu@%s", aws_key_pair.remote_access.key_name, aws_instance.main_server.public_dns)
}
