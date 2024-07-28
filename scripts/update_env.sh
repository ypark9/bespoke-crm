#!/bin/bash

# Store the root directory
ROOT_DIR=$(pwd)

# Change to the terraform directory
cd terraform/environments/dev || exit

# Run terraform output and capture the results
user_pool_id=$(terraform output -raw cognito_user_pool_id)
client_id=$(terraform output -raw cognito_client_id)
client_secret=$(terraform output -raw cognito_client_secret)
region=$(terraform output -raw aws_region)

# Change back to the root directory
cd "$ROOT_DIR"

# Create the directory if it doesn't exist
mkdir -p src/bespoke-crm-frontend

# Update .env.local file
cat << EOF > src/bespoke-crm-frontend/.env.local
COGNITO_CLIENT_ID=$client_id
COGNITO_CLIENT_SECRET=$client_secret
COGNITO_ISSUER=https://cognito-idp.$region.amazonaws.com/$user_pool_id
EOF

echo ".env.local file has been updated with Cognito details."