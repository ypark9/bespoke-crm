# Bespoke CRM

A multi-cloud CRM system deployed on AWS and Azure.

## Project Structure

- `terraform/`: Infrastructure as Code (Terraform)
  - `modules/`: Reusable Terraform modules for AWS and Azure resources
    - `aws/`: AWS-specific resources such as compute, database, networking, and storage
    - `azure/`: Azure-specific resources equivalent to AWS services
    - `common/`: Shared configurations across both AWS and Azure
  - `environments/`: Separate environments for development, staging, and production
    - `dev/`
    - `staging/`
    - `prod/`
  - `global/`: Global configurations and variables
- `src/`: Source code for microservices and frontend
  - `services/`: Microservices for different CRM functionalities
    - `user-management/`: Manages user-related operations
    - `contact-management/`: Manages contact-related operations
    - `lead-management/`: Manages lead-related operations
    - `opportunity-management/`: Manages opportunity-related operations
    - `reporting/`: Handles reporting and analytics
  - `api-gateway/`: API Gateway configuration and code
  - `frontend/`: Frontend application
- `scripts/`: Utility scripts for various tasks such as deployment, setup, and maintenance
- `tests/`: Test suites for unit, integration, and end-to-end testing
- `docs/`: Project documentation including architecture, design, and user guides

## Getting Started

To set up the development environment for Bespoke CRM, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/bespoke-crm.git
   cd bespoke-crm
   ```

1. **Install required tools:**

   - [Terraform](https://www.terraform.io/downloads.html)
   - [Node.js](https://nodejs.org/en/download/)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) [FUTURE]
   - [Docker](https://www.docker.com/products/docker-desktop) [FUTURE]

1. **Set up environment variables:**
   Add the required environment variables for AWS and Azure credentials in Github Repo after cloning.
   Make sure you've added the AWS credentials as secrets in your GitHub repository:

   1. Go to your GitHub repository
   1. Click on "Settings"
   1. Click on "Secrets" in the left sidebar
   1. Click on "New repository secret"
   1. Add AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as separate secrets

1. **Initialize Terraform:**
   ```bash
   cd terraform/environments/dev
   terraform init
   ```
1. **Review Terraform deploy plan**

   ```bash
   cd terraform/environments/dev
   terraform plan
   ```

1. **Deploy infrastructure:**

   ```bash
   terraform apply -auto-approve
   ```

1. **Build and run the microservices:** [FUTURE]

   ```bash
   cd src/services
   docker-compose up --build
   ```

1. ** Deploy the frontend:** [FUTURE]
   ```bash
   cd src/frontend
   npm install
   npm start
   ```

## Contributing

We welcome contributions to the Bespoke CRM project! To contribute, please follow these guidelines:

1. **Fork the repository:**
   Click on the "Fork" button at the top of the repository page.

2. **Clone your forked repository:**

   ```bash
   git clone https://github.com/your-username/bespoke-crm.git
   cd bespoke-crm
   ```

3. **Create a new branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes and commit them:**

   ```bash
   git add .
   git commit -m "Add your commit message"
   ```

5. **Push your changes to your forked repository:**

   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a pull request:**
   Go to the original repository and click on the "New pull request" button. Provide a clear description of your changes and submit the pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
