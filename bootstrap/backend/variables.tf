variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "aws-enterprise-terraform"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "bootstrap"
}