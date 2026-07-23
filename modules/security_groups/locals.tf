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

  ingress_rules = {

    alb = [
      {
        description   = "HTTP"
        from_port     = 80
        to_port       = 80
        protocol      = "tcp"
        cidr_ipv4     = "0.0.0.0/0"
        source_sg_key = null
      },
      {
        description   = "HTTPS"
        from_port     = 443
        to_port       = 443
        protocol      = "tcp"
        cidr_ipv4     = "0.0.0.0/0"
        source_sg_key = null
      }
    ]

    ec2 = [
      {
        description   = "HTTP from ALB"
        from_port     = 80
        to_port       = 80
        protocol      = "tcp"
        cidr_ipv4     = null
        source_sg_key = "alb"
      }
    ]

    rds = [
      {
        description   = "MySQL from EC2"
        from_port     = 3306
        to_port       = 3306
        protocol      = "tcp"
        cidr_ipv4     = null
        source_sg_key = "ec2"
      }
    ]

  }

  egress_rules = {

    alb = [
      {
        description   = "Allow all outbound"
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_ipv4     = "0.0.0.0/0"
        source_sg_key = null
      }
    ]

    ec2 = [
      {
        description   = "Allow all outbound"
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_ipv4     = "0.0.0.0/0"
        source_sg_key = null
      }
    ]

    rds = [
      {
        description   = "Allow all outbound"
        from_port     = 0
        to_port       = 0
        protocol      = "-1"
        cidr_ipv4     = "0.0.0.0/0"
        source_sg_key = null
      }
    ]

  }

  flattened_ingress_rules = flatten([
    for sg_name, rules in local.ingress_rules : [
      for rule in rules : merge(rule, {
        security_group = sg_name
      })
    ]
  ])

  flattened_egress_rules = flatten([
    for sg_name, rules in local.egress_rules : [
      for rule in rules : merge(rule, {
        security_group = sg_name
      })
    ]
  ])

}