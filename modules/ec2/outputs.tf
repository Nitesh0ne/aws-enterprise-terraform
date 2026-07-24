output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "launch_template_id" {
  value = aws_launch_template.this.id
}