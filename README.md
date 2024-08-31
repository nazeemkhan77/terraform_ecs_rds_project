# Terraform ECS and RDS Deployment

This README provides instructions on how to execute the Terraform scripts to deploy an AWS ECS Fargate service with a Docker container and an RDS MySQL instance. The script will configure the necessary infrastructure, including VPC, subnets, ECS cluster, ECS task definition, and security groups.

## Prerequisites

Before running the Terraform scripts, ensure you have the following installed and configured:

- [Terraform](https://www.terraform.io/downloads) (version 1.9.5 or later)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials and region
- An AWS account with permissions to create ECS, RDS, and networking resources

## Execution Steps

1. **Clone the Repository**

    ```bash
    git clone https://github.com/nazeemkhan77/terraform_ecs_rds_project.git
    cd terraform_ecs_rds_project
    ```

2. **Modify `terraform.tfvars`**

    Edit the `terraform.tfvars` file to adjust the variables for your deployment:

    ```bash
    vim terraform.tfvars
    ```

    Example parameters:

    - `aws_region`: The AWS region (e.g., `us-west-2`)
    - `aws_profile`: The AWS profile (e.g., `test-user`)
    - `app_name`: The application name (e.g., `demo-app`)
    - 'vpc_id': VPC ID (e.g., vpc-xxxxxxx)
    - `subnets_ecs`: Provide a list of subnets where ECS cluster will be created (e.g., ["subnet-aaaa", "subnet-bbbb"] )
    - 'rds_engine_version': RDS MySQL engine version (fog e,g,. 8.0.33)
    - `rds_instance_type`: The instance type for your RDS (e.g., `db.t2.micro`)
    - `rds_db_name`: The name of the database (e.g., `mydb`)
    - `db_username`: The master username for the RDS (e.g., `admin`)
    - `db_password`: The master password for the RDS (e.g., `YourPassword123`)
    - `subnets_rds`: Provide a list of subnets where RDS cluster will be created (e.g., ["subnet-xxx", "subnet-yyy"] )
    - `ecs_image`: The Docker image to deploy (e.g., `two-tier-flask-app`)

3. **Initialize Terraform**

    ```bash
    terraform init
    ```

4. **Plan the Deployment**

    ```bash
    terraform plan
    ```

5. **Apply the Terraform Configuration**

    ```bash
    terraform apply
    ```

    Confirm the creation of resources by typing `yes` when prompted.

6. **Retrieve Outputs**

    After the deployment, Terraform will output key information like the ECS service's public IP and the RDS endpoint. Note these for accessing your service.

7. **Verify the Deployment**

    Ensure that the ECS service is running and accessible by navigating to the public IP or DNS name provided by Terraform.

## Parameters to Change

- **VPC Configuration**:
  - `vpc_cidr`: CIDR block for the VPC
  - `public_subnet_cidr`: CIDR block for the public subnet

- **ECS and Docker Configuration**:
  - `ecs_cluster_name`: Name of the ECS cluster
  - `docker_image`: Docker image to deploy in ECS

- **RDS Configuration**:
  - `rds_instance_type`: The instance type for RDS (e.g., `db.t3.micro`)
  - `rds_db_name`: Name of the database
  - `db_username`: Master username for the RDS database
  - `db_password`: Master password for the RDS database

## Troubleshooting

- **Terraform Errors**: Adjust the configuration according to the error message or check your AWS permissions.
- **Access Issues**: Verify security group rules and network ACLs to allow necessary traffic.

## Cleanup

To remove the resources created by Terraform:

```bash
terraform destroy
