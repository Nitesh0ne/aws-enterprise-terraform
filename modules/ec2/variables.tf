variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ec2_security_group_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = null
}

variable "instance_profile_name" {
  description = "IAM Instance Profile attached to the EC2 instance"
  type        = string
}




variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 30
}