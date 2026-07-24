resource "aws_lb" "this" {

  name               = local.alb_name
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  enable_deletion_protection = false

  idle_timeout = 60

  tags = {
    Name = local.alb_name
  }

}


resource "aws_lb_target_group" "this" {

  name = local.target_group_name

  port     = 80
  protocol = "HTTP"

  vpc_id = var.vpc_id

  target_type = "instance"

  health_check {

    enabled = true

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    interval = 30

    timeout = 5

    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = local.target_group_name
  }
}





resource "aws_lb_listener" "http" {

  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.this.arn

  }

}