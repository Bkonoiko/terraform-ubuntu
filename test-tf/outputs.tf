output "ec2_publicIP" {
  value = aws_instance.my_instance.public_ip
}

output "ec2_publicDNS" {
  value = aws_instance.my_instance.public_dns
}

output "ec2_ID" {
  value = aws_instance.my_instance.id
}

output "ec2_tags" {
  value = aws_instance.my_instance.tags
}