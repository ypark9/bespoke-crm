provider "aws" {
  region = var.region
}

module "networking" {
  source               = "../../modules/aws/networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "user_management_lambda" {
  source = "../../modules/aws/lambda"
  # Add any necessary variables here
  workos_api_key = var.workos_api_key
  workos_client_id = var.workos_client_id
}

# module "database" {
#   source = "../../modules/aws/database"
#   ...
# }

module "frontend" {
  source      = "../../modules/aws/frontend"
  app_name    = "bespoke-crm"
  environment = var.environment
}

output "frontend_url" {
  value = "http://${module.frontend.website_endpoint}"
}

module "cognito" {
  source      = "../../modules/aws/cognito"
  app_name    = "bespoke-crm"
  environment = var.environment
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_client_id" {
  value = module.cognito.client_id
}

output "cognito_client_secret" {
  value     = module.cognito.client_secret
  sensitive = true
}

output "cognito_domain" {
  value = module.cognito.cognito_domain
}

output "aws_region" {
  value = var.region
  description = "The AWS region used for this deployment"
}