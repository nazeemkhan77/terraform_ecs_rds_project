variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets_ecs" {
  description = "Subnets for ECS"
  type        = list(string)
}