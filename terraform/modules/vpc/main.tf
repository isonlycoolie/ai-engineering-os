# VPC module — network foundation stub
#
# Provides private/public subnets, routing, and baseline security groups.
# Replace provider resources with your cloud provider (AWS, GCP, Azure).

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.0"
    # }
  }
}

variable "name_prefix" {
  description = "Prefix for resource names (e.g. ai-os-dev)"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "AZs for subnet placement"
  type        = list(string)
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

# --- Stub resources (uncomment and adapt for target provider) ---

# resource "aws_vpc" "main" {
#   cidr_block           = var.cidr_block
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags                 = merge(var.tags, { Name = "${var.name_prefix}-vpc" })
# }

# resource "aws_subnet" "private" {
#   count             = length(var.availability_zones)
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = cidrsubnet(var.cidr_block, 4, count.index)
#   availability_zone = var.availability_zones[count.index]
#   tags              = merge(var.tags, { Name = "${var.name_prefix}-private-${count.index}" })
# }

output "vpc_id" {
  description = "VPC identifier"
  value       = null # aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "Private subnet identifiers"
  value       = [] # aws_subnet.private[*].id
}
