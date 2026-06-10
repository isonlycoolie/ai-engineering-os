# Development environment — composes shared modules with dev-sized resources

terraform {
  required_version = ">= 1.5.0"

  # Uncomment and configure remote state before team use:
  # backend "s3" {
  #   bucket = "org-terraform-state"
  #   key    = "ai-engineering-os/dev/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

variable "name_prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "ai-os-dev"
}

variable "region" {
  description = "Cloud region"
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "service_image" {
  description = "Application container image"
  type        = string
  default     = "org/api:dev"
}

locals {
  common_tags = {
    Environment = "dev"
    Project     = "ai-engineering-os"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = var.name_prefix
  cidr_block         = "10.10.0.0/16"
  availability_zones = var.availability_zones
  tags               = local.common_tags
}

module "database" {
  source = "../../modules/database"

  name_prefix            = var.name_prefix
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids
  instance_class         = "db.t4g.micro"
  allocated_storage_gb   = 20
  backup_retention_days  = 1
  multi_az               = false
  tags                   = local.common_tags
}

module "service" {
  source = "../../modules/service"

  name_prefix   = var.name_prefix
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  image         = var.service_image
  cpu           = 256
  memory        = 512
  desired_count = 1
  environment = {
    APP_ENV  = "development"
    LOG_LEVEL = "debug"
  }
  tags = local.common_tags
}

output "service_endpoint" {
  description = "Dev service endpoint"
  value       = module.service.service_endpoint
}
