data "aws_availability_zones" "available" {
  state = "available"
}






resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.vpc_name
  }
}

#internet_gateway 

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = local.igw_name
  }
}



#subnet


resource "aws_subnet" "public" {

  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Tier = "Public"
  }
}


resource "aws_subnet" "private_app" {

  for_each = local.private_app_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Tier = "Private-App"
  }
}





resource "aws_subnet" "private_db" {

  for_each = local.private_db_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.key}"
    Tier = "Private-DB"
  }
}



#  route table

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}



resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt"
  }
}



resource "aws_route" "public_internet_access" {

  route_table_id = aws_route_table.public.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.this.id
}



resource "aws_route_table_association" "public" {

  for_each = aws_subnet.public

  subnet_id = each.value.id

  route_table_id = aws_route_table.public.id
}




resource "aws_route_table_association" "private_app" {

  for_each = aws_subnet.private_app

  subnet_id = each.value.id

  route_table_id = aws_route_table.private.id
}



resource "aws_route_table_association" "private_db" {

  for_each = aws_subnet.private_db

  subnet_id = each.value.id

  route_table_id = aws_route_table.private.id
}