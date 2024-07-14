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

# You can add other modules here as we develop them
# module "compute" {
#   source = "../../modules/aws/compute"
#   ...
# }

# module "database" {
#   source = "../../modules/aws/database"
#   ...
# }
