data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

}



resource "aws_launch_template" "this" {

  name = local.launch_template_name

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [
    var.ec2_security_group_id
  ]

  update_default_version = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  monitoring {
    enabled = false
  }

  iam_instance_profile {

    name = var.instance_profile_name

  }



  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.root_volume_size
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {

    resource_type = "instance"

    tags = {
      Name = local.instance_name
    }
  }

  tag_specifications {

    resource_type = "volume"

    tags = {
      Name = "${local.instance_name}-root"
    }
  }

  tags = {
    Name = local.launch_template_name
  }
}





resource "aws_instance" "this" {

  subnet_id = var.private_subnet_ids[0]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tags = {
    Name = local.instance_name
  }
}



