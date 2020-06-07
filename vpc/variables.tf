variable "name" {
  type        = string
  description = "The name of the resource"
}

variable "vpc_cidr_range" {
  type        = string
  description = "the CIDR range of the VPC"
}

variable "public_route_cidr_block" {
  type        = string
  description = "the destination CIDR block got the public route"
}