pipeline {
  // Run pipeline on any available agent
  agent any

  // Define environment variables with credentials from Jenkins credential store
  environment {
    AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    AWS_DEFAULT_REGION = "us-east-1"
  }

  parameters {
  choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform on the EKS cluster')
}

  // Define pipeline stages
  stages {
    // Stage 1: Checkout the source code from GitHub repository
    stage('Checkout SCM') {
      steps {
        script {
          // Checkout code from the 'main' branch of your repository (update URL and branch name as needed)
          checkout scmGit(
              branches: [[name: '*/main']],
              extensions: [],
              userRemoteConfigs: [[url: 'https://github.com/kartik-rathore/terraform-jenkins-eks.git']]
          )
        }
      }
    }

    // Stage 2: Initialize Terraform workspace
    stage('Initializing Terraform') {
      steps {
        script {
         
          dir('EKS') {
            // Run 'terraform init' to initialize Terraform and download required plugins
            sh 'terraform init'
          }
        }
      }
    }

    // Stage 3: Format Terraform code for readability (optional but recommended)
    stage('Formatting Terraform Code') {
      steps {
        script {
          dir('EKS') {
            // Run 'terraform fmt' to format Terraform code for better readability
            sh 'terraform fmt'
          }
        }
      }
    }

    // Stage 4: Validate Terraform configuration syntax
    stage('Validating Terraform') {
      steps {
        script {
          dir('EKS') {
            // Run 'terraform validate' to check for syntax errors and potential issues
            sh 'terraform validate'
          }
        }
      }
    }

    // Stage 5: Preview infrastructure changes using Terraform plan
    stage('Previewing the Infra using Terraform') {
      steps {
        script {
          dir('EKS') {
            // Run 'terraform plan' to preview the changes Terraform will make
            sh 'terraform plan'
            // Prompt user for confirmation before proceeding (optional)
            input message: "Are you sure to proceed?", ok: "Proceed"
          }
        }
      }
    }

    // Stage 6: Create or destroy EKS cluster based on the action parameter
    stage('Creating/Destroying an EKS Cluster') {
      steps {
        script {
          dir('EKS') {
            // Define a variable for the action with choices 'apply' and 'destroy'
            def action = params.action
    // Run 'terraform $action' to create or destroy the EKS cluster
            sh "terraform ${action} --auto-approve"
    // Remove --auto-approve for manual confirmation


            
          }
        }
      }
    }

    // Stage 7: Deploy Nginx application to the EKS cluster
    stage('Deploying Nginx Application') {
      steps {
        script {
          // Change directory to the 'K8s-ConfigurationFiles' directory within the 'EKS' directory
          dir('EKS/K8s-ConfigurationFiles') {

            // Update kubeconfig 
            sh "aws eks update-kubeconfig --name kartik-eks-jenkins-terraform"

            // Deploy Nginx deployment and service using kubectl commands
            sh 'kubectl apply -f deployment.yaml'
            sh 'kubectl apply -f service.yaml'
          }
        }
      }
    }
  }
}

