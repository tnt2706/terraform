resource "aws_lb" "app" {
  name               = var.aws_lb-name
  internal           = false
  security_groups    = var.alb-security_groups
  subnets            = var.public_subnet_ids

  tags = {
    Name = "nginx-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name     = var.aws_lb-target_group-name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
