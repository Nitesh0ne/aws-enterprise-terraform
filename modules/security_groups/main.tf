resource "aws_security_group" "this" {

  for_each = local.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = {
    Name = each.value.name
  }
}

###############################################################################
# Ingress Rules
###############################################################################

resource "aws_vpc_security_group_ingress_rule" "this" {

  for_each = {
    for rule in local.flattened_ingress_rules :
    "${rule.security_group}-${replace(lower(rule.description), " ", "-")}" => rule
  }

  security_group_id = aws_security_group.this[each.value.security_group].id

  description = each.value.description

  from_port   = each.value.from_port
  to_port     = each.value.to_port
  ip_protocol = each.value.protocol

  cidr_ipv4 = each.value.cidr_ipv4

  referenced_security_group_id = (
    each.value.source_sg_key != null
    ? aws_security_group.this[each.value.source_sg_key].id
    : null
  )
}

###############################################################################
# Egress Rules
###############################################################################


resource "aws_vpc_security_group_egress_rule" "this" {

  for_each = {
    for rule in local.flattened_egress_rules :
    "${rule.security_group}-${replace(lower(rule.description), " ", "-")}" => rule
  }

  security_group_id = aws_security_group.this[each.value.security_group].id

  description = each.value.description

  ip_protocol = each.value.protocol

  from_port = each.value.protocol == "-1" ? null : each.value.from_port
  to_port   = each.value.protocol == "-1" ? null : each.value.to_port

  cidr_ipv4 = each.value.cidr_ipv4
}