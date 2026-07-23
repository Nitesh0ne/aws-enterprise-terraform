



#subnet locals

locals {

  vpc_name = "${var.project_name}-${var.environment}-vpc"
  igw_name = "${var.project_name}-${var.environment}-igw"

  public_subnets = {
    public-a = {
      cidr = var.public_subnet_cidrs[0]
      az   = data.aws_availability_zones.available.names[0]
    }
    public-b = {
      cidr = var.public_subnet_cidrs[1]
      az   = data.aws_availability_zones.available.names[1]
    }
  }

  private_app_subnets = {
    app-a = {
      cidr = var.private_app_subnet_cidrs[0]
      az   = data.aws_availability_zones.available.names[0]
    }
    app-b = {
      cidr = var.private_app_subnet_cidrs[1]
      az   = data.aws_availability_zones.available.names[1]
    }
  }

  private_db_subnets = {
    db-a = {
      cidr = var.private_db_subnet_cidrs[0]
      az   = data.aws_availability_zones.available.names[0]
    }
    db-b = {
      cidr = var.private_db_subnet_cidrs[1]
      az   = data.aws_availability_zones.available.names[1]
    }
  }
}