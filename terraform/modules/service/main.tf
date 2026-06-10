# Service module — compute / container service stub
#
# Deploys application workloads (ECS service, Cloud Run, Kubernetes deployment).
# Wire to VPC module outputs for subnet and security group placement.

terraform {
  required_version = ">= 1.5.0"
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID from vpc module"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for service placement"
  type        = list(string)
}

variable "image" {
  description = "Container image URI (include digest in production)"
  type        = string
}

variable "cpu" {
  description = "CPU units for the task / container"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory (MiB) for the task / container"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of running tasks / replicas"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Plain environment variables (non-secret)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

# --- Stub resources ---

# resource "aws_ecs_service" "main" {
#   name            = "${var.name_prefix}-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.main.arn
#   desired_count   = var.desired_count
#   launch_type     = "FARGATE"
#
#   network_configuration {
#     subnets          = var.subnet_ids
#     security_groups  = [aws_security_group.service.id]
#     assign_public_ip = false
#   }
#
#   tags = var.tags
# }

output "service_name" {
  description = "Deployed service name"
  value       = "${var.name_prefix}-service"
}

output "service_endpoint" {
  description = "Internal or load-balanced endpoint"
  value       = null
}
