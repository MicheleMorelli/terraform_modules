resource "aws_security_group" "base" {
  name_prefix = "${var.name}-base"

  tags = {
    Name = "${var.name}_base_SG"
  }
}


resource "aws_security_group_rule" "allow_ports_to_ips" {
  count             = length(var.port_list)
  type              = "ingress"
  from_port         = var.port_list[count.index]
  to_port           = var.port_list[count.index]
  protocol          = "tcp"
  cidr_blocks       = var.cidr_list
  security_group_id = aws_security_group.base.id
}

resource "aws_security_group_rule" "outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.base.id
}
