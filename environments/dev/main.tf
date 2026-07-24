provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}



module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr

  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
}



module "security_groups" {
  source = "../../modules/security_groups"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id
}




module "alb" {

  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  public_subnet_ids = module.vpc.public_subnet_ids

  alb_security_group_id = module.security_groups.security_group_ids["alb"]

}





module "ec2" {

  source = "../../modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_app_subnet_ids

  ec2_security_group_id = module.security_groups.security_group_ids["ec2"]

  instance_type = "t3.micro"

  key_name = null

  instance_profile_name = module.iam.instance_profile_name

  root_volume_size = 30
}



module "iam" {

  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment

}