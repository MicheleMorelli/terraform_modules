resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_range
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}


# From the TF doc:
# Note that the default route, mapping the VPC's CIDR block to "local", is created implicitly and cannot be specified.
# https://www.terraform.io/docs/providers/aws/r/default_route_table.html
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-public-rt"
  }
}


resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this
  depends_on             = [aws_route_table.public]

  tags = {
    Name = "${var.name}-public-route"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = {
    Name = "${var.name}-default-route-table"
  }
}
