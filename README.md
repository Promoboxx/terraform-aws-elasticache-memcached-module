A Terraform module to create a Memcached ElastiCache cluster.
===========

A terraform module providing a Memcached ElastiCache cluster in AWS.

This module

- Creates Memcached ElastiCache clusters
- Creates, manages, and exports a security group

----------------------
#### Required
- `env` - env to deploy into, should typically be dev/staging/prod
- `name` - Name for the Memcached cluster i.e. UserObject
- `memcached_clusters` - Number of Memcached cache clusters (nodes) to create
- `subnets` - List of VPC Subnet IDs for the cache subnet group
- `vpc_id`  - VPC ID


#### Optional

- `apply_immediately` - Specifies whether any modifications are applied immediately, or during the next maintenance window. Defaults to false.
- `allowed_cidr` - A list of Security Group ID's to allow access to. Defaults to localhost.
- `availability_zones` - A list of the Availability Zones in which cache nodes are created. Requires `memcached_clusters` > 1.
- `allowed_security_groups` - A list of Security Group ID's to allow access to. Defaults to empty list.
- `memcached_node_type` - Instance type to use for creating the Memcached cache clusters. Defaults to cache.t2.micro.
- `memcached_port` - Defaults to 11211.
- `memcached_version` - Memcached version to use, defaults to 1.4.33.
- `memcached_parameters` - The additional parameters modifyed in parameter group.
- `memcached_maintenance_window` - Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.

Usage
-----

```hcl
module "memcached" {
  source         = "github.com/terraform-community-modules/tf_aws_elasticache_memcached?ref=v0.1.0"
  env            = "${var.env}"
  name           = "thtest"
  subnets        = "${module.vpc.database_subnets}"
  vpc_id         = "${module.vpc.vpc_id}"
}
```