output "vpc_id" {
  value = "vpc-0531999bac150f396"
}

output "subnet_id" {
  value = "subnet-0bdd2bf458fd2f00f"
}

output "security_group_id" {
  value = "sg-0ea6b508f978e04be"
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "ecs_service_name" {
  value = aws_ecs_service.hello_world.name
}

