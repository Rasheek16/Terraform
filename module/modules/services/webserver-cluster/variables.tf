variable "cluster_name" {
  description = "The name to use for all the cluster resources"

  type = string
}

variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket for the database's remote state"
  type        = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in S3"
  type        = string
}


variable "instance_type" {
  description = "The type of ec2 instance"
  type        = string
}

variable "min_size" {
  description = "The minimun number of ec2 instances."
  type        = string
}

variable "max_size" {
  description = "The maximum number of ec2 instances."
  type        = string
}