variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets_rds" {
  description = "Private subnets for RDS"
  type        = list(string)
}

variable "rds_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "rds_engine_version" {
  description = "The version of the RDS engine"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance."
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type for the RDS instance."
  type        = string
  default     = "gp2"
}

variable "parameter_group_name" {
  description = "The parameter group name to associate with the RDS instance."
  type        = string
  default     = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot before deletion."
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible."
  type        = bool
  default     = false
}