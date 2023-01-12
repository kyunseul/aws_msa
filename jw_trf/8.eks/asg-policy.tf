/*resource "aws_autoscaling_policy" "sp1" {
  name                   = "scaling-policy"
  #scaling_adjustment     = 4
  policy_type            = "TargetTrackingScaling"
  #adjustment_type        = "ChangeInCapacity"
  #cooldown               = 60
  autoscaling_group_name = aws_eks_node_group.AWSb-ng-1.resources[0].autoscaling_groups[0].name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 10.0
  }

  depends_on = [
    aws_eks_node_group.AWSb-ng-1
  ]
}

resource "aws_autoscaling_policy" "sp2" {
  name                   = "scaling-policy"
  #scaling_adjustment     = 4
  policy_type            = "TargetTrackingScaling"
  #adjustment_type        = "ChangeInCapacity"
  #cooldown               = 60
  autoscaling_group_name = aws_eks_node_group.AWSb-ng-2.resources[0].autoscaling_groups[0].name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 10.0
  }

  depends_on = [
    aws_eks_node_group.AWSb-ng-2
  ]
}*/