locals {
  vpc_name = "${var.project_name}-${var.environment}-vpc"

  igw_name = "${var.project_name}-${var.environment}-igw"
}