#addon-2번째 시도
resource "aws_eks_addon" "kube-proxy" {
  depends_on = [
    aws_eks_node_group.AWSb-ng-1,
    aws_eks_node_group.AWSb-ng-2
  ]
  cluster_name = aws_eks_cluster.AWSb-eks.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "coredns" {
  depends_on = [
    aws_eks_node_group.AWSb-ng-1,
    aws_eks_node_group.AWSb-ng-2
  ]
  cluster_name = aws_eks_cluster.AWSb-eks.name
  addon_name   = "coredns"
}
resource "aws_eks_addon" "vpc-cni" {
  depends_on = [
    aws_eks_node_group.AWSb-ng-1,
    aws_eks_node_group.AWSb-ng-2
  ]
  cluster_name = aws_eks_cluster.AWSb-eks.name
  addon_name   = "vpc-cni"
}