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

update-env:
	./scripts/update_env.sh

destroy-aws:
	terraform -chdir=terraform/environments/dev destroy -auto-approve

# TODO Azure commands (assuming we'll have a similar structure for Azure)
init-azure:
	terraform -chdir=terraform/environments/dev-azure init

plan-azure:
	terraform -chdir=terraform/environments/dev-azure plan

apply-azure:
	terraform -chdir=terraform/environments/dev-azure apply -auto-approve

destroy-azure:
	terraform -chdir=terraform/environments/dev-azure destroy -auto-approve

# Combined commands
# TODO init-azure is not included here yet.
init: init-aws
# TODO plan-azure is not included here yet.
plan: plan-aws
# TODO apply-azure is not included here yet.
apply: apply-aws update-env
# TODO destroy-azure is not included here yet.
destroy: destroy-aws

teardown: destroy

test:
	echo "Running tests..."
	# Add actual test commands here
