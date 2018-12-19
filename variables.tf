variable "apply_immediately" {
  description = "Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false."
  default     = "false"
}

variable "allowed_cidr" {
  type        = "list"
  default     = ["127.0.0.1/32"]
  description = "A list of Security Group ID's to allow access to."
}

variable "allowed_security_groups" {
  type        = "list"
  default     = []
  description = "A list of Security Group ID's to allow access to."
}

variable "env" {
  description = "env to deploy into, should typically dev/staging/prod"
}

variable "name" {
  description = "Name for the Memcached replication group i.e. UserObject"
}

variable "memcached_clusters" {
  description = "Number of Memcached cache clusters (nodes) to create"
}

variable "memcached_node_type" {
  description = "Instance type to use for creating the Memcached cache clusters"
  default     = "cache.t2.micro"
}

variable "memcached_port" {
  default = 11211
}

variable "subnets" {
  type        = "list"
  description = "List of VPC Subnet IDs for the cache subnet group"
}

variable "memcached_version" {
  description = "Memcached version to use, defaults to 1.4.33"
  default     = "1.4.33"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "memcached_parameters" {
  type        = "list"
  description = "additional parameters modifyed in parameter group"
  default     = []
}

variable "memcached_maintenance_window" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period"
  default     = "fri:08:00-fri:09:00"
}

variable "availability_zones" {
  type        = "list"
  description = "List of the Availability Zones in which cache nodes are create"
}

variable "tags" {
  description = "tags to add to these resources tags (e.g. `map('Team','XYZ')`"
  default     = {}
}
