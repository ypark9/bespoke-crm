variable "region" {
  description = "AWS region for the bespoke-crm project"
  default     = "us-east-2"
}

variable "environment" {
  description = "Environment name for the bespoke-crm project"
  default     = "bespoke-dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC in the bespoke-crm project"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets in the bespoke-crm project"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets in the bespoke-crm project"
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for the bespoke-crm project"
  default     = ["us-east-2a", "us-east-2b"]
}

variable "workos_api_key" {
  description = "WorkOS API Key"
  type        = string
}

variable "workos_client_id" {
  description = "WorkOS Client ID"
  type        = string
}