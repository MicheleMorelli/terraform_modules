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
  default = "0.0.0.0/0"
}

variable "public_subnets_cidr_blocks_list" {
  type        = list(string)
  description = "A list of CIDR ranges of the public subnets of the VPC"
}


variable "private_subnets_cidr_blocks_list" {
  type        = list(string)
  description = "A list of CIDR ranges of the private subnets of the VPC"
}
