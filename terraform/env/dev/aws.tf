
terraform {
  backend "s3" {
    bucket = "terraform.bespoke.crm"
    key    = "env/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source      = "../../modules/aws/network"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

# output "aws_vpc_id" {
#   value = module.network.vpc_id
# }

# output "aws_subnet_ids" {
#   value = module.network.subnet_ids
# }