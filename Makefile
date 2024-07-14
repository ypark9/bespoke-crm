.PHONY: init plan apply destroy test

init:
	terraform -chdir=terraform/environments/dev init

plan:
	terraform -chdir=terraform/environments/dev plan

apply:
	terraform -chdir=terraform/environments/dev apply

destroy:
	terraform -chdir=terraform/environments/dev destroy

test:
	echo "Running tests..."
	# Add actual test commands here
