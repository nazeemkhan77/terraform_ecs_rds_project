output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_endpoint_without_port" {
  value = module.rds.rds_endpoint_without_port
}

output "ecs_cluster_arn" {
  value = module.ecs.ecs_cluster_arn
}

# output "alb_arn" {
#   value = module.alb.alb_arn
# }

# output "alb_dns_name" {
#   value = module.alb.alb_dns_name
# }

# output "alb_target_group_arn" {
#   value = module.alb.alb_target_group_arn
# }