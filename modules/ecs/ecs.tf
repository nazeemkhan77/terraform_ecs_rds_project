resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets           = var.subnets_ecs
    security_groups   = [aws_security_group.ecs_sg.id]
    assign_public_ip  = true
  }
  # load_balancer {
  #   target_group_arn = var.alb_target_group_arn
  #   container_name   = "web"
  #   container_port   = 80
  # }

  tags = {
    Name = "${var.app_name}-service"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "/ecs/${var.app_name}-task-logs"
  retention_in_days = 7  # Adjust the retention period as needed
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role     = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_logs_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn  = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_ecs_task_definition" "ecs_task" {
  family                = "${var.app_name}-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "256"
  memory                = "512"
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn

  container_definitions    = jsonencode([{
    name      = "${var.app_name}-container"
    image     = var.ecs_image
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
        "awslogs-region"        = "us-west-2"
        "awslogs-stream-prefix" = "demo-app-container"
      }
    }
    environment = [
      {
        name  = "MYSQL_HOST"
        value = var.rds_endpoint
      },
      {
        name  = "MYSQL_DB"
        value = "mydb"
      },
      {
        name  = "MYSQL_USER"
        value = "admin"
      },
      {
        name  = "MYSQL_PASSWORD"
        value = "YourPassword123"
      }
    ]
  }])

  tags = {
    Name = "${var.app_name}-task"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-ecs-security-group"
  description = "Allow outbound traffic to RDS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic on port 443 (for ECR image pull)
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
