# Database module — managed database stub
#
# Provisions a managed relational database with encryption, backups, and
# private network access. Place in private subnets from the VPC module.

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
  description = "Private subnet IDs for DB subnet group"
  type        = list(string)
}

variable "engine" {
  description = "Database engine (postgres, mysql, etc.)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "16"
}

variable "instance_class" {
  description = "Instance size (provider-specific)"
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage_gb" {
  description = "Initial storage in GB"
  type        = number
  default     = 20
}

variable "backup_retention_days" {
  description = "Automated backup retention"
  type        = number
  default     = 7
}

variable "multi_az" {
  description = "Enable multi-AZ for high availability"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

# --- Stub resources ---

# resource "aws_db_instance" "main" {
#   identifier              = "${var.name_prefix}-db"
#   engine                  = var.engine
#   engine_version          = var.engine_version
#   instance_class          = var.instance_class
#   allocated_storage       = var.allocated_storage_gb
#   db_subnet_group_name    = aws_db_subnet_group.main.name
#   vpc_security_group_ids  = [aws_security_group.database.id]
#   backup_retention_period = var.backup_retention_days
#   multi_az                = var.multi_az
#   storage_encrypted       = true
#   skip_final_snapshot     = false
#   deletion_protection     = true
#   tags                    = var.tags
# }

output "database_endpoint" {
  description = "Database hostname (sensitive — use in secrets manager)"
  value       = null
  sensitive   = true
}

output "database_port" {
  description = "Database port"
  value       = 5432
}
