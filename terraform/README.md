# Terraform

Infrastructure-as-code layout for provisioning VPC, services, and data stores across environments.

## Layout

```
terraform/
├── modules/
│   ├── vpc/        # Network foundation (subnets, routing, security groups)
│   ├── service/    # Compute / container service (ECS, Cloud Run, etc.)
│   └── database/   # Managed database (RDS, Cloud SQL, etc.)
└── environments/
    ├── dev/
    ├── staging/
    └── prod/
```

## Principles

- **Modules are reusable** - environments compose modules; avoid environment-specific logic inside modules.
- **State is isolated per environment** - separate remote state backends (S3 + DynamoDB, GCS, Terraform Cloud).
- **Variables drive divergence** - instance sizes, replica counts, and CIDR blocks differ by env; module interfaces stay stable.
- **Secrets never in tfvars committed to git** - use secret managers and CI-injected variables.

## Getting started

```bash
cd terraform/environments/dev
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Create `terraform.tfvars` locally (gitignored) with environment-specific values. See each environment's `main.tf` for required variables.

## Remote state (recommended)

Configure a backend block in each environment before production use:

```hcl
terraform {
  backend "s3" {
    bucket         = "org-terraform-state"
    key            = "ai-engineering-os/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

## Module versioning

Pin module sources to tagged releases in production:

```hcl
module "vpc" {
  source = "git::https://github.com/org/terraform-modules.git//vpc?ref=v1.0.0"
}
```

## Related documentation

- [SRE pre-production checklist](../agents/sre-engineer/checklists/pre-production.md)
- [Monitoring alerts](../monitoring/)
- [Observability standards](../standards/observability.md)
