variable "name" {
  type        = string
  description = "Name prefix of the SG"
}

variable "port_list" {
  type        = list(string)
  description = "List of ports to create rules for"
}

variable "cidr_list" {
  type        = list(string)
  description = "List of CIDRs"
}
