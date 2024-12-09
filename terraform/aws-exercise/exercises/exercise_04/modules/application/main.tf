resource "aws_launch_template" "application" {
  name          = "web"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_path

  network_interfaces {
    security_groups = var.sg_application
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx-instance"
    }
  }

  user_data = filebase64("${path.module}/ec2.userdata")
}

resource "aws_autoscaling_group" "nginx" {
  name             = "nginx-asg"
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.application.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  target_group_arns = [var.alb_target_group] 

  tag {
    key                 = "Name"
    value               = "application-instance"
    propagate_at_launch = true
  }
}

