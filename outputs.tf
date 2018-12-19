output "memcached_security_group_id" {
  value = "${aws_security_group.memcached_security_group.id}"
}

output "parameter_group" {
  value = "${aws_elasticache_parameter_group.memcached_parameter_group.id}"
}

output "memcached_subnet_group_name" {
  value = "${aws_elasticache_subnet_group.memcached_subnet_group.name}"
}

output "id" {
  value = "${aws_elasticache_cluster.memcached.id}"
}

output "port" {
  value = "${var.memcached_port}"
}

output "endpoint" {
  value = "${aws_elasticache_cluster.memcached.configuration_endpoint}"
}
