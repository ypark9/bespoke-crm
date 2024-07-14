#!/bin/bash

# Navigate to the user-management service directory
cd src/services/user-management

# Install dependencies
npm install

# Build and package the lambda
npm run package

# Move the zip file to a location Terraform can find
mkdir -p ../../../terraform/modules/aws/lambda/files
mv function.zip ../../../terraform/modules/aws/lambda/files/user-management.zip

# Navigate back to the root directory
cd ../../../
