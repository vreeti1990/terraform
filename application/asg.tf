resource "aws_autoscaling_group" "api_asg" {
  vpc_zone_identifier  = data.aws_subnet_ids.private.ids
  name                 = var.env_name
  max_size             = var.asg_max
  min_size             = var.asg_min
  desired_capacity     = var.asg_desired
  force_delete         = true
  health_check_type    = "ELB"
  target_group_arns    = [aws_lb_target_group.api_tg.arn]
  launch_template {
    id                 = aws_launch_template.api-lt.id
    version            = aws_launch_template.api-lt.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = [

    {
    key                 = "Name"
    value               = var.env_name
    propagate_at_launch = "true"
  },

  {
    key                 = "environment"
    value               = var.env_type
    propagate_at_launch = "true"
  },

  {
    key                 = "terraform"
    value               = "true"
    propagate_at_launch = "true"
  }
] 
}

resource "aws_autoscaling_policy" "api_scale_up_policy" {
  name                   = "api-scale-up-policy"
  policy_type            = "StepScaling"
  step_adjustment {
  scaling_adjustment          = 1
  metric_interval_lower_bound = 0.0
  metric_interval_upper_bound = ""
}
  estimated_instance_warmup = 300
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}


resource "aws_autoscaling_policy" "api_scale_down_policy" {
  name                   = "api-scale-down-policy"
  policy_type            = "StepScaling"
  step_adjustment {
  scaling_adjustment          = -1
  metric_interval_lower_bound = ""
  metric_interval_upper_bound = 0.0
}
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.api_asg.name
}

