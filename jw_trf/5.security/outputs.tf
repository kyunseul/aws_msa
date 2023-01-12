output "bastion_id" {
  value = aws_security_group.bastion.id
}

output "mgmt_id" {
  value = aws_security_group.mgmt.id
}

output "db_id" {
  value = aws_security_group.db.id
}
output "docdb_id" {
  value = aws_security_group.docdb.id
}

output "eks_id" {
  value = aws_security_group.eks.id
}

/*output "node_id" {
  value = aws_security_group.node.id
}*/

output "jenkins_id" {
  value = aws_security_group.jenkins.id
}

output "alb_id" {
  value = aws_security_group.alb.id
}

output "efs_id" {
  value = aws_security_group.efs.id
}