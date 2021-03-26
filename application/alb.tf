#AWS Application Load balancer
resource "aws_lb" "api-alb" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = var.lb_type
  security_groups            = [aws_security_group.alb-sg.id]
  subnets                    = data.aws_subnet_ids.public.ids
  idle_timeout               = var.lb_idle_timeout
  enable_deletion_protection = false

  tags = {
    environment     = var.env_type
    terraform       = "true"
  }
}

#AWS ALB Target Group
resource "aws_lb_target_group" "api_tg" {
  name     = var.tg_alb_target_group
  port     = 80
  protocol = "HTTP"
  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 120
    matcher             = "200-399"
  }
  vpc_id = module.vpc.vpc_id
}

#AWS Listener
resource "aws_lb_listener" "api_80" {
  load_balancer_arn = aws_lb.api-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tg.arn
  }
}

#Autoscaling Attachment
resource "aws_autoscaling_attachment" "api_asg_attachment" {
  alb_target_group_arn   = aws_lb_target_group.api_tg.arn
  autoscaling_group_name = aws_autoscaling_group.api_asg.id
}

resource "aws_security_group" "alb-sg" {
    name = var.security_group_name
    description = "Allow SSH and Http inbound traffic"
    vpc_id = module.vpc.vpc_id
    #SSH access
    ingress {
        from_port = var.ingress_from_port
        to_port = var.ingress_to_port
        protocol = var.ingress_protocol
        cidr_blocks = [var.aws_ingress_cidr_block]
    }

     ingress {
        from_port = var.ingress_from_port-80
        to_port = var.ingress_to_port-80
        protocol = var.ingress_protocol-80
        cidr_blocks = [var.aws_ingress_cidr_block-80]
    }

    #outbound internet access
    egress {
        from_port = var.egress_from_port
        to_port = var.egress_to_port
        protocol = var.egress_protocol
        cidr_blocks = [var.aws_egress_cidr_block]
    }      
}