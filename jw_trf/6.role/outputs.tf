output "eks-role-arn" {
  value = aws_iam_role.AWSb-eks-role.arn
}

output "ng-role-arn" {
  value = aws_iam_role.AWSb-ng-role.arn
}

output "ecp" {
  value = aws_iam_role_policy_attachment.ecp
}

output "evrc" {
  value = aws_iam_role_policy_attachment.evrc
}

output "AWSb-workernode-policy" {
  value = aws_iam_role_policy_attachment.AWSb-workernode-policy
}

output "AWSb-cni-policy" {
  value = aws_iam_role_policy_attachment.AWSb-cni-policy
}

output "AWSb-CRR" {
  value = aws_iam_role_policy_attachment.AWSb-CRR
}