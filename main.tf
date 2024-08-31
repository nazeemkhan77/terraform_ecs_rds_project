provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "rds" {
  source                 = "./modules/rds"
  vpc_id = var.vpc_id
  app_name = var.app_name
  subnets_rds = var.subnets_rds
  rds_engine_version     = var.rds_engine_version
  rds_instance_class         = var.instance_class
  db_name                = var.db_name
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  db_username               = var.db_username
  db_password               = var.db_password
  parameter_group_name   = var.parameter_group_name
  skip_final_snapshot    = var.skip_final_snapshot
  publicly_accessible    = var.publicly_accessible
  # vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

module "ecs" {
  source                = "./modules/ecs"
  app_name              = var.app_name
  ecs_image             = var.ecs_image
  vpc_id                = var.vpc_id
  subnets_ecs           = var.subnets_ecs
  # alb_target_group_arn  = module.alb.alb_target_group_arn
  rds_endpoint          = module.rds.rds_endpoint
  rds_endpoint_without_port = module.rds.rds_endpoint_without_port
}

# module "alb" {
#   source               = "./modules/alb"
#   app_name = var.app_name
#   vpc_id               = var.vpc_id
#   subnets_ecs = var.subnets_ecs
#   # subnet_ids           = var.subnet_ids
#   # ecs_target_group_arn = module.ecs.target_group_arn
# }