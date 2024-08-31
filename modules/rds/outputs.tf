output "rds_endpoint" {
  value = aws_db_instance.rds_instance.address
}

# Extract just the endpoint without port
# output "rds_endpoint_without_port" {
#   value = replace(aws_db_instance.rds_instance.endpoint, ":[0-9]+$", "")
# }

output "rds_endpoint_without_port" {
  value = element(split(":", aws_db_instance.rds_instance.endpoint), 0)
}