variable "region" {
  description = "AWS region for the Bespoke CRM project"
  type        = string
}

variable "environment" {
  description = "Environment name for the Bespoke CRM project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC in the Bespoke CRM project"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets in the Bespoke CRM project"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets in the Bespoke CRM project"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the Bespoke CRM project"
  type        = list(string)
}
