#nodegroup
resource "aws_eks_node_group" "AWSb-ng-1" {
  cluster_name    = aws_eks_cluster.AWSb-eks.name
  node_group_name = "AWSb-NG-1"
  node_role_arn   = data.terraform_remote_state.role.outputs.ng-role-arn
  subnet_ids      = [data.terraform_remote_state.vpc.outputs.node_a]

  /*launch_template {
    name    = aws_launch_template.lt-ng1.name
    version = "1"
  }*/

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = format("%s-ng1", aws_eks_cluster.AWSb-eks.name)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  /*depends_on = [
    aws_iam_role_policy_attachment.AWSb-workernode-policy,
    aws_iam_role_policy_attachment.AWSb-cni-policy,
    aws_iam_role_policy_attachment.AWSb-CRR,
    # aws_launch_template.lt-ng1
  ]*/
}

resource "aws_eks_node_group" "AWSb-ng-2" {
  cluster_name    = aws_eks_cluster.AWSb-eks.name
  node_group_name = "AWSb-NG-2"
  node_role_arn   = data.terraform_remote_state.role.outputs.ng-role-arn
  subnet_ids      = [data.terraform_remote_state.vpc.outputs.node_c]

  /*launch_template {
    name    = aws_launch_template.lt-ng2.name
    version = "1"
  }*/

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = format("%s-ng2", aws_eks_cluster.AWSb-eks.name)
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  /*depends_on = [
    aws_iam_role_policy_attachment.AWSb-workernode-policy,
    aws_iam_role_policy_attachment.AWSb-cni-policy,
    aws_iam_role_policy_attachment.AWSb-CRR,
    # aws_launch_template.lt-ng2
  ]*/
}

/*#node-group-launch-template
resource "aws_launch_template" "lt-ng1" {
  instance_type = "t3.medium"
  key_name      = aws_key_pair.mykey.key_name
  name          = format("at-lt-%s-ng1", aws_eks_cluster.AWSb-eks.name)
  # user_data     = base64encode(local.eks-node-private-userdata)
  tags = {
    Name = "launch template ng1"
  }
  image_id = "ami-031edd8e214914974"
  user_data            = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids = [aws_security_group.node.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = format("%s-ng1", aws_eks_cluster.AWSb-eks.name)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_launch_template" "lt-ng2" {
  instance_type = "t3.medium"
  key_name      = aws_key_pair.mykey.key_name
  name          = format("at-lt-%s-ng2", aws_eks_cluster.AWSb-eks.name)
  user_data     = base64encode(local.eks-node-private-userdata)
  tags = {
    Name = "launch template ng2"
  }
  image_id = "ami-031edd8e214914974"
  #user_data            = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids = [aws_security_group.node.id]
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = format("%s-ng2", aws_eks_cluster.AWSb-eks.name)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}*/