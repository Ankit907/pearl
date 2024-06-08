# main.tf

provider "aws" {
  region = "ap-south-1" # Set your desired AWS region
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "hello_world_task" {
  family                   = "hello-world-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  
  container_definitions = jsonencode([
    {
      name      = "hello-world-container"
      image     = "ankit8770/hello-world-nodejs:latest"
      cpu       = 256
      memory    = 512
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 3000,
          protocol      = "tcp",
        },
      ],
    },
  ])
}

resource "aws_ecs_service" "hello_world_service" {
  name            = "hello-world-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.hello_world_task.arn
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.main.id] # Replace with your subnet ID
    security_groups = [aws_security_group.allow_http.id]   # Replace with your security group ID
    assign_public_ip = true
  }
}
