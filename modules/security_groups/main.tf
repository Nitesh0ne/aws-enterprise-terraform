resource "aws_security_group" "this" {

  for_each = local.security_groups

  name        = each.value.name
  description = each.value.description

  vpc_id = var.vpc_id

  tags = {
    Name = each.value.name
  }

}