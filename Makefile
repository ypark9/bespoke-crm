.PHONY: init plan apply destroy test teardown

# AWS commands
init-aws:
	terraform -chdir=terraform/environments/dev init

build-lambdas:
	./scripts/build-lambdas.sh

plan-aws: build-lambdas
	terraform -chdir=terraform/environments/dev plan

apply-aws: build-lambdas
	terraform -chdir=terraform/environments/dev apply -auto-approve

destroy-aws:
	terraform -chdir=terraform/environments/dev destroy -auto-approve

# Azure commands (assuming you'll have a similar structure for Azure)
init-azure:
	terraform -chdir=terraform/environments/dev-azure init

plan-azure:
	terraform -chdir=terraform/environments/dev-azure plan

apply-azure:
	terraform -chdir=terraform/environments/dev-azure apply -auto-approve

destroy-azure:
	terraform -chdir=terraform/environments/dev-azure destroy -auto-approve

# Combined commands
# init-azure is not included here as it's not needed for the example
init: init-aws
# plan-azure is not included here as it's not needed for the example
plan: plan-aws
# apply-azure is not included here as it's not needed for the example
apply: apply-aws
# destroy-azure is not included here as it's not needed for the example
destroy: destroy-aws

teardown: destroy

test:
	echo "Running tests..."
	# Add actual test commands here
