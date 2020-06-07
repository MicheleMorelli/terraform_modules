resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_range
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}
