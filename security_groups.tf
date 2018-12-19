resource "aws_security_group" "memcached_security_group" {
  name        = "${format("%.255s", "tf-sg-ec-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}")}"
  description = "Terraform-managed ElastiCache security group for ${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}"
  vpc_id      = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "tf-sg-ec-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}"
  }
}

resource "aws_security_group_rule" "memcached_ingress" {
  count                    = "${length(var.allowed_security_groups)}"
  type                     = "ingress"
  from_port                = "${var.memcached_port}"
  to_port                  = "${var.memcached_port}"
  protocol                 = "tcp"
  source_security_group_id = "${element(var.allowed_security_groups, count.index)}"
  security_group_id        = "${aws_security_group.memcached_security_group.id}"
}

resource "aws_security_group_rule" "memcached_networks_ingress" {
  type              = "ingress"
  from_port         = "${var.memcached_port}"
  to_port           = "${var.memcached_port}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.allowed_cidr}"]
  security_group_id = "${aws_security_group.memcached_security_group.id}"
}
