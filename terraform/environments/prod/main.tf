# Production environment — HA defaults, stricter retention, pinned images

terraform {
  required_version = ">= 1.5.0"

  # backend "s3" {
  #   bucket = "org-terraform-state"
  #   key    = "ai-engineering-os/prod/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

variable "name_prefix" {
  type    = string
  default = "ai-os-prod"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "service_image" {
  description = "Immutable image URI with digest (required in prod)"
  type        = string
}

locals {
  common_tags = {
    Environment = "production"
    Project     = "ai-engineering-os"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = var.name_prefix
  cidr_block         = "10.30.0.0/16"
  availability_zones = var.availability_zones
  tags               = local.common_tags
}

module "database" {
  source = "../../modules/database"

  name_prefix           = var.name_prefix
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  instance_class        = "db.r6g.large"
  allocated_storage_gb  = 100
  backup_retention_days = 30
  multi_az              = true
  tags                  = local.common_tags
}

module "service" {
  source = "../../modules/service"

  name_prefix   = var.name_prefix
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  image         = var.service_image
  cpu           = 1024
  memory        = 2048
  desired_count = 3
  environment = {
    APP_ENV   = "production"
    LOG_LEVEL = "info"
  }
  tags = local.common_tags
}

output "service_endpoint" {
  value = module.service.service_endpoint
}
