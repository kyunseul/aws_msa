resource "aws_lb_target_group" "jenkins-tg" {
  name                 = "AWSb-jenkins-target-group"
  port                 = 8080
  protocol             = "HTTP"
  deregistration_delay = 120
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "jenkins-tg-a" {
  target_group_arn = aws_lb_target_group.jenkins-tg.arn
  target_id        = aws_instance.jenkins_a.id
  port             = 8080
}

resource "aws_lb" "alb" {
  name               = "AWSb-jenkins-alb"
  load_balancer_type = "application"
  subnets            = [data.terraform_remote_state.vpc.outputs.pub_a, data.terraform_remote_state.vpc.outputs.pub_c]
  security_groups    = [data.terraform_remote_state.security.outputs.alb_id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404 : PAGE NOT FOUND\n"
      status_code  = 404
    }
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins-tg.arn
  }
}