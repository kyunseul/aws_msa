output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.awsb-db.endpoint
}

output "user-db_endpoint" {
  description = "DocDB instance endpoint"
  value       = aws_docdb_cluster.user-db.endpoint
}

output "cart-docdb_endpoint" {
  description = "DocDB instance endpoint"
  value       = aws_docdb_cluster.cart-db.endpoint
}