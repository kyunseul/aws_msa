output "vpc_id" {
  value = aws_vpc.main.id
}

output "mgmt_a" {
  value = aws_subnet.mgmt_a.id
}

output "mgmt_c" {
  value = aws_subnet.mgmt_c.id
}

output "pub_a" {
  value = aws_subnet.pub_a.id
}

output "pub_c" {
  value = aws_subnet.pub_c.id
}

output "node_a" {
  value = aws_subnet.node_a.id
}

output "node_c" {
  value = aws_subnet.node_c.id
}

output "db_a" {
  value = aws_subnet.db_a.id
}

output "db_c" {
  value = aws_subnet.db_c.id
}