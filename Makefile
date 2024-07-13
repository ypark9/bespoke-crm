# Define variables
ENV          ?= dev
TERRAFORM    = terraform -chdir=./terraform/env/$(ENV)
AWS_PROFILE  ?= default
# AZURE_SUBSCRIPTION_ID ?= your-azure-subscription-id
# Check if AZURE_SUBSCRIPTION_ID is set
# ifeq ($(AZURE_SUBSCRIPTION_ID),your-azure-subscription-id)
# $(error AZURE_SUBSCRIPTION_ID is not set)
# endif
# Required tools
REQUIRED_BINS := terraform aws # az
# Check if required tools are installed
$(foreach bin,$(REQUIRED_BINS),\
	$(if $(shell command -v $(bin) 2> /dev/null),,$(error Please install `$(bin)`)))
# Default target
all: init validate plan
# Initialize the Terraform environment
init:
	$(TERRAFORM) init
# Validate the Terraform configuration
validate:
	$(TERRAFORM) validate
# Generate an execution plan
plan:
	$(TERRAFORM) plan
# Apply the Terraform configuration
apply:
	@echo "Applying Terraform configuration. Please confirm."
	$(TERRAFORM) apply -auto-approve
# Destroy the Terraform-managed infrastructure
destroy:
	$(TERRAFORM) destroy -auto-approve
# Clean up generated files
clean:
	rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl
# AWS authentication
aws-login:
	@echo "Logging in to AWS using profile $(AWS_PROFILE)..."
	aws sts get-caller-identity --profile $(AWS_PROFILE)
# Azure authentication
# azure-login:
# 	@echo "Logging in to Azure..."
# 	az login
# 	az account set --subscription $(AZURE_SUBSCRIPTION_ID)
# Show help message
help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all       - Initialize, validate, and plan the Terraform configuration"
	@echo "  init      - Initialize the Terraform environment"
	@echo "  validate  - Validate the Terraform configuration"
	@echo "  plan      - Generate an execution plan"
	@echo "  apply     - Apply the Terraform configuration (requires confirmation)"
	@echo "  destroy   - Destroy the Terraform-managed infrastructure"
	@echo "  clean     - Clean up generated files"
	@echo "  aws-login - Log in to AWS using the specified profile"
#	@echo "  azure-login - Log in to Azure and set the specified subscription"
.PHONY: all init validate plan apply destroy clean aws-login # azure-login help