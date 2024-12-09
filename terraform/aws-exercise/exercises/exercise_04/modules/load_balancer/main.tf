data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  #userdata
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #! /bin/bash
    apt-get -y update
    apt-get -y install nginx
    apt-get -y install jq

    ALB_DNS=${aws_lb.app.dns_name}
    MONGODB_PRIVATEIP=${var.mongodb_ip}
    
    mkdir -p /tmp/cloudacademy-app
    cd /tmp/cloudacademy-app

    echo ===========================
    echo FRONTEND - download latest release and install...
    mkdir -p ./voteapp-frontend-react-2023
    pushd ./voteapp-frontend-react-2023
    curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2023/releases/latest | jq -r '.assets[0].browser_download_url' | xargs curl -OL
    INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2023/releases/latest | jq -r '.assets[0].name')
    tar -xvzf $INSTALL_FILENAME
    rm -rf /var/www/html
    cp -R build /var/www/html
    cat > /var/www/html/env-config.js << EOFF
    window._env_ = {REACT_APP_APIHOSTPORT: "$ALB_DNS"}
    EOFF
    popd

    echo ===========================
    echo API - download latest release, install, and start...
    mkdir -p ./voteapp-api-go
    pushd ./voteapp-api-go
    curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .browser_download_url' | xargs curl -OL
    INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .name')
    tar -xvzf $INSTALL_FILENAME
    #start the API up...
    MONGO_CONN_STR=mongodb://$MONGODB_PRIVATEIP:27017/langdb ./api &
    popd

    systemctl restart nginx
    systemctl status nginx
    echo fin v1.00!

    EOF    
  }
}


resource "aws_lb" "app" {
  name               = var.aws_lb-name
  internal           = false
  security_groups    = var.sg_elb
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

resource "aws_launch_template" "app_template" {
  name          = "web"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_path

  network_interfaces {
    security_groups = var.instance-security_groups
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nginx-instance"
    }
  }

  user_data = base64encode(data.template_cloudinit_config.config.rendered)
}

resource "aws_autoscaling_group" "nginx" {
  name             = "nginx-asg"
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  target_group_arns = [var.alb_target_group] 

  tag {
    key                 = "Name"
    value               = "nginx-instance"
    propagate_at_launch = true
  }
}

