resource "aws_eks_cluster" "AWSb-eks" {
  name     = var.cluster_name
  role_arn = data.terraform_remote_state.role.outputs.eks-role-arn

  vpc_config {
    subnet_ids = [
      data.terraform_remote_state.vpc.outputs.node_a,
      data.terraform_remote_state.vpc.outputs.node_c
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = [data.terraform_remote_state.security.outputs.eks_id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  /*depends_on = [
    data.terraform_remote_state.role.outputs.ecp,
    data.terraform_remote_state.role.outputs.evrc
  ]*/
}