variable "app_name" {
  description = "Application Name"
  type        = string
}

variable "ecs_image" {
  description = "ECR image repository for ECS instances"
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

# variable "alb_target_group_arn" {
#   description = "The ARN of the ALB target group"
#   type        = string
# }

variable "rds_endpoint" {
  description = "AWS RDS instance endpoint"
  type        = string
}

variable "rds_endpoint_without_port" {
  description = "AWS RDS instance endpoint without port"
  type        = string
}