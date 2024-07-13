variable "aws_vpc_cidr" {
  description = "The CIDR block for the AWS VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_subnet_cidrs" {
  description = "List of subnet CIDRs for the AWS VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azure_vnet_cidr" {
  description = "The CIDR block for the Azure VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azure_subnet_cidrs" {
  description = "List of subnet CIDRs for the Azure VNet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}