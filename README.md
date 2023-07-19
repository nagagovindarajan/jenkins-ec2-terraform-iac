# Jenkins Installation on AWS EC2 with HTTPS ALB using Terraform

This guide will walk you through the process of setting up Jenkins on an AWS EC2 instance, along with an HTTPS ALB, using Terraform for infrastructure provisioning.

## Prerequisites

Before you begin, make sure you have the following prerequisites:

- An AWS account with appropriate permissions
- Terraform installed on your local machine
- AWS CLI installed and configured with your AWS credentials

## Steps

### Step 1: Create an EC2 Key Pair

Start by creating an EC2 key pair that will be used to access your EC2 instance securely. You can create a key pair from the AWS Management Console or by using the AWS CLI.

### Step 2: Clone the Repository

Clone this repository to your local machine. It contains the Terraform configuration files and necessary scripts.

git clone <repository-url>
cd <repository-directory>

### Step 3: Update Variables
Open the terraform.tfvars file and update the variables as per your requirements. Provide the desired values for variables such as aws_region, aws_access_key, aws_secret_key, ec2_key_name, etc.

### Step 4: Initialize Terraform
Initialize Terraform in the repository directory by running the following command:

Copy code
terraform init

### Step 5: Plan and Apply
Now, let's review the planned infrastructure changes before applying them. Run the following command:

Copy code
terraform plan
If the plan looks good, proceed with applying the changes:

Copy code
terraform apply
Terraform will create the necessary AWS resources, including the EC2 instance, security groups, ALB, and associated resources.

### Step 6: Access Jenkins
Once the Terraform apply is successful, you can access Jenkins by opening the ALB DNS name provided in the Terraform output. The URL should be in the format https://<alb-dns-name>. Allow a few minutes for the ALB to be fully provisioned before accessing Jenkins.

### Step 7: Jenkins Setup
On the Jenkins web interface, you'll be prompted to enter an initial administrator password. SSH into your EC2 instance using the key pair created earlier, and retrieve the password by running the following command:

Copy code
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Copy the password and paste it into the Jenkins web interface to complete the initial setup.

### Step 8: Configure HTTPS
To enable HTTPS for your Jenkins installation, you can configure SSL/TLS certificates using the ALB. Follow the AWS documentation to obtain and configure the SSL/TLS certificates for your ALB.

### Step 9: Clean Up
To clean up and destroy the provisioned resources when you're done, run the following command:

Copy code
terraform destroy
Confirm the destruction by typing "yes" when prompted.

## Conclusion
You have successfully deployed Jenkins on an AWS EC2 instance, configured with an HTTPS ALB using Terraform. You can now start using Jenkins for your continuous integration and delivery needs.

Please note that this is a general guide, and you may need to adapt it to your specific requirements. Refer to the Terraform documentation and AWS documentation for further details and customization options.

Enjoy using Jenkins in your AWS environment!

Please note that this content may contain placeholders such as `<repository-url>` and `<repository-directory>`. Make sure to replace them with the actual values based on your repository details.