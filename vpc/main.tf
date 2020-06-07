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
}

resource "aws_default_route_table" "default-private" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = {
    Name = "${var.name}-default-private-route-table"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr_blocks_list)
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnets_cidr_blocks_list[count.index]
  availability_zone       = count.index % 2 == 0 ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr_blocks_list)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets_cidr_blocks_list[count.index]
  availability_zone = count.index % 2 == 0 ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.name}-private-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id

  depends_on = [aws_subnet.public, aws_route_table.public]
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private) 
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_default_route_table.default-private.id

  depends_on = [aws_subnet.private, aws_default_route_table.default-private]
}