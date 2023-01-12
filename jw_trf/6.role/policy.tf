#eks-role-policy
resource "aws_iam_role_policy_attachment" "ecp" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.AWSb-eks-role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "evrc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.AWSb-eks-role.name
}

#ng-role-policy
resource "aws_iam_role_policy_attachment" "AWSb-workernode-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.AWSb-ng-role.name
}

resource "aws_iam_role_policy_attachment" "AWSb-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.AWSb-ng-role.name
}

resource "aws_iam_role_policy_attachment" "AWSb-CRR" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.AWSb-ng-role.name
}

resource "aws_iam_role_policy_attachment" "AWSb-appmesh" {
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshFullAccess"
  role       = aws_iam_role.AWSb-ng-role.name
}