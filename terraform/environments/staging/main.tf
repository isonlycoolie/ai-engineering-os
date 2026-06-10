# Staging environment — pre-production parity with reduced scale

terraform {
  required_version = ">= 1.5.0"

  # backend "s3" {
  #   bucket = "org-terraform-state"
  #   key    = "ai-engineering-os/staging/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

variable "name_prefix" {
  type    = string
  default = "ai-os-staging"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "service_image" {
  type    = string
  default = "org/api:staging"
}

locals {
  common_tags = {
    Environment = "staging"
    Project     = "ai-engineering-os"
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = var.name_prefix
  cidr_block         = "10.20.0.0/16"
  availability_zones = var.availability_zones
  tags               = local.common_tags
}

module "database" {
  source = "../../modules/database"

  name_prefix           = var.name_prefix
  vpc_id                = module.vpc.vpc_id
  subnet_ids            = module.vpc.private_subnet_ids
  instance_class        = "db.t4g.small"
  allocated_storage_gb  = 50
  backup_retention_days = 7
  multi_az              = false
  tags                  = local.common_tags
}

module "service" {
  source = "../../modules/service"

  name_prefix   = var.name_prefix
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
  image         = var.service_image
  cpu           = 512
  memory        = 1024
  desired_count = 2
  environment = {
    APP_ENV   = "staging"
    LOG_LEVEL = "info"
  }
  tags = local.common_tags
}

output "service_endpoint" {
  value = module.service.service_endpoint
}
