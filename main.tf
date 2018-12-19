data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

resource "aws_elasticache_cluster" "memcached" {
  cluster_id                   = "${var.name}"
  engine                       = "memcached"
  engine_version               = "${var.memcached_version}"
  node_type                    = "${var.memcached_node_type}"
  num_cache_nodes              = "${var.memcached_clusters}"
  parameter_group_name         = "${aws_elasticache_parameter_group.memcached_parameter_group.id}"
  subnet_group_name            = "${aws_elasticache_subnet_group.memcached_subnet_group.id}"
  security_group_ids           = ["${aws_security_group.memcached_security_group.id}"]
  maintenance_window           = "${var.memcached_maintenance_window}"
  port                         = "${var.memcached_port}"
  az_mode                      = "${var.memcached_clusters == 1 ? "single-az" : "cross-az" }"
  preferred_availability_zones = ["${slice(var.availability_zones, 0, var.memcached_clusters)}"]
  tags                         = "${merge(map("Name","tf-elasticache-${var.name}-${data.aws_vpc.vpc.tags["Name"]}"), var.tags)}"
}

resource "aws_elasticache_parameter_group" "memcached_parameter_group" {
  name        = "${replace(format("%.255s", lower(replace("tf-memcached-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}", "_", "-"))), "/\\s/", "-")}"
  description = "Terraform-managed ElastiCache parameter group for ${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}"

  # Strip the patch version from memcached_version var
  family    = "memcached${replace(var.memcached_version, "/\\.[\\d]+$/","")}"
  parameter = "${var.memcached_parameters}"
}

resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name       = "${replace(format("%.255s", lower(replace("tf-memcached-${var.name}-${var.env}-${data.aws_vpc.vpc.tags["Name"]}", "_", "-"))), "/\\s/", "-")}"
  subnet_ids = ["${var.subnets}"]
}
