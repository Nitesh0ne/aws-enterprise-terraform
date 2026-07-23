locals {

  security_groups = {

    alb = {
      name        = "${var.project_name}-${var.environment}-alb-sg"
      description = "Application Load Balancer Security Group"
    }

    ec2 = {
      name        = "${var.project_name}-${var.environment}-ec2-sg"
      description = "Application EC2 Security Group"
    }

    rds = {
      name        = "${var.project_name}-${var.environment}-rds-sg"
      description = "RDS Security Group"
    }

  }

  

    alb_ingress_rules = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  alb_egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

}
