locals {

  role_name = "${var.project_name}-${var.environment}-ec2-role"

  instance_profile_name = "${var.project_name}-${var.environment}-instance-profile"

}