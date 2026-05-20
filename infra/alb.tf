resource "aws_lb" "gatus" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type

  security_groups = [
    module.security_groups.alb_sg_id
  ]

  subnets = module.vpc.public_subnet_ids

}

resource "aws_lb_target_group" "gatus" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_group_type
  vpc_id      = module.vpc.vpc_id

  health_check {
    path    = var.health_check_path
    matcher = var.health_check_matcher
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.gatus.arn
  port              = var.http_listener_port
  protocol          = var.http_listener_protocol

  default_action {
    type = "redirect"

    redirect {
      port        = var.redirect_port
      protocol    = var.redirect_protocol
      status_code = var.redirect_status_code
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.gatus.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.cert.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gatus.arn
  }
}
