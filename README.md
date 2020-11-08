# lambdaTerraform Project
 _A demonstration of terraform deployment for a lambda microservice_ 


This project deploys two lambda functions connected to a DynamoDB database.
One Lambda Function takes a value to put inside the database, and one lambda function gets all the values from the database.

## dev/prod Environments

This project makes use of tfvar files to set the variables for individual environments. The CIDR range for the VPC and subnets can be set in these files, as well as the availability zones and database hashkey. 
To apply the terraform deployment using these variables, specify the file during the terraform apply command.
#### Example: terraform apply -var-file=<name>.tfvars
 
If no tfvars file is specified, the deployment will use the default values found inside the variables.tf file for each module. 

## Modules

### VPC Module
This module creates a VPC with public subnets and private subnets. The public subnets are connected to an Internet Gateway and the Private subnets are connected to a Nat Gateway. 

The module will create as many subnets as there are CIDR Blocks defined in the tfvars file for the variables: pubsubnetcidrs and privsubnetcidrs. The module will create one subnet for each cidr range. 

The module also creates a security group that allows ingress traffic from port 443 and egress from all cidr ranges. 

### Lambda Module
This module creates the two lambda functions. The code for the functions are postFunc.js and getFunc.js. 
#### The code for the lambda functions are stored in the S3 bucket: terraform-serverless-example323.
A role is also created for the lambda functions to assume. The policies attached to the role allow the lambda function to interact with the DynamoDB database.

### API Gateway
This module creates the API resource along with the methods for GET and POST for the lambda functions. 

### Database
This module creates the DynamoDB database and declares the hashkey the database will use to store the items.
