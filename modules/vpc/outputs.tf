output "vpc_id" {
  description = "VPC ID"

  value = aws_vpc.this.id
}

output "vpc_cidr" {
  description = "VPC CIDR"

  value = aws_vpc.this.cidr_block
}


output "internet_gateway_id" {
  description = "Internet Gateway ID"

  value = aws_internet_gateway.this.id
}



#subnet output


output "public_subnet_ids" {
  value = values(aws_subnet.public)[*].id
}

output "private_app_subnet_ids" {
  value = values(aws_subnet.private_app)[*].id
}

output "private_db_subnet_ids" {
  value = values(aws_subnet.private_db)[*].id
}



output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}