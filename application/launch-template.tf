resource "aws_launch_template" "api-lt" {
  name = "api-lt"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 100
    }
  }

  ebs_optimized = false

  iam_instance_profile {
    name = aws_iam_instance_profile.api-profile.name
  }

  image_id = var.ami_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = var.key_name


  vpc_security_group_ids = [aws_security_group.allow-ssh-only.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "api-lt"
    }
  }

  user_data = base64encode(data.template_file.user_data.rendered)
}

resource "aws_security_group" "allow-ssh-only" {
    name = var.instance-api-sg
    description = "Allow SSH inbound traffic"
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
        cidr_blocks = [var.aws_ingress_cidr_block-instance-80]
    }

    #outbound internet access
    egress {
        from_port = var.egress_from_port
        to_port = var.egress_to_port
        protocol = var.egress_protocol
        cidr_blocks = [var.aws_egress_cidr_block]
    }      
}

resource "aws_iam_instance_profile" "api-profile" {
  name = var.api_profile
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.api_instance_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }      
      },
      
    ]
  })

}

resource "aws_iam_policy" "policy" {
  name        = "s3-static-website-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::vreeti-static-website",
                "arn:aws:s3:::vreeti-code-bucket"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": [
                "arn:aws:ssm:us-west-2:927204861883:parameter/dev/vreeti-api-db/vreeti-api-db-password"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::vreeti-static-website/*",
                "arn:aws:s3:::vreeti-code-bucket/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}