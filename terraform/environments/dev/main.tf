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
}

# module "database" {
#   source = "../../modules/aws/database"
#   ...
# }
