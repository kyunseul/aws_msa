output "mgmt_ip_a" {
  value = aws_instance.mgmt_a.private_ip
}
output "mgmt_ip_c" {
  value = aws_instance.mgmt_c.private_ip
}
output "bastion_ip_a" {
  value = aws_instance.bastion_a.public_ip
}
output "bastion_ip_c" {
  value = aws_instance.bastion_c.public_ip
}
output "jenkins_ip_a" {
  value = aws_instance.jenkins_a.private_ip
}
output "jenkins_ip_c" {
  value = aws_instance.jenkins_c.private_ip
}
output "alb_dns_name" {
  description = "The domain name of the load balancer"
  value       = aws_lb.alb.dns_name
}