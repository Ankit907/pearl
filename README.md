# Hello World Node.js App on AWS ECS/Fargate with Terraform and GitHub Actions given by PEARL THOUGHTS ORGANISATION
PEARL THOUGHTS TASK (ANKIT CHOUREY)
This project demonstrates how to deploy a simple "Hello World" Node.js application on AWS ECS/Fargate using Terraform for infrastructure as code and GitHub Actions for continuous deployment.

## Prerequisites

1. AWS Account
2. Terraform installed
3. GitHub repository for your Node.js application
4. AWS CLI configured with the necessary permissions

## Setup Instructions

### Step 1: Setup Terraform for AWS ECS/Fargate

1. Clone the repository and navigate to the Terraform configuration directory.

    ```sh
    git clone <repository-url>
    cd terraform-ecs-fargate
    ```

2. Initialize and apply the Terraform configuration.

    ```sh
    terraform init
    terraform apply
    ```

### Step 2: Configure GitHub Actions for Continuous Deployment

1. Create a `.github/workflows/cd.yml` file in your repository with the following content:

    ```yaml
    name: CD Pipeline

    on:
      push:
        branches:
          - main

    jobs:
      deploy:
        runs-on: ubuntu-latest

        steps:
          - name: Checkout code
            uses: actions/checkout@v2

          - name: Set up Docker Buildx
            uses: docker/setup-buildx-action@v1

          - name: Log in to Amazon ECR
            id: ecr-login
            uses: aws-actions/amazon-ecr-login@v1

          - name: Build and push Docker image
            run: |
              IMAGE_URI=${{ steps.ecr-login.outputs.registry }}/hello-world:latest
              for example  ankit9770/hello-world:latest
              docker build -t $IMAGE_URI .
              docker push $IMAGE_URI
            env:
              AWS_REGION: ap-south-1

          - name: Deploy to ECS
            run: |
              aws ecs update-service --cluster hello-world-cluster --service hello-world-service --force-new-deployment
            env:
              AWS_REGION: ap-south-1
              AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
              AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
    ```

2. Ensure you have the following secrets configured in your GitHub repository settings:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

### Step 3: Deploy and Verify

1. Push your code to the `main` branch.
2. Verify the deployment in the AWS ECS console.

## Conclusion

I have successfully set up an AWS ECS/Fargate infrastructure for your Node.js application using Terraform and created a CD pipeline using GitHub Actions. Happy coding!
