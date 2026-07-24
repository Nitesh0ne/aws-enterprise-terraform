locals {

  alb_name = "${var.project_name}-${var.environment}-alb"

  target_group_name = "${var.project_name}-${var.environment}-tg"

}