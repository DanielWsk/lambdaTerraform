resource "aws_lambda_function" "getfunc" {
   function_name = "GetFunction"

   # The S3 bucket that contains the function code
   s3_bucket = "terraform-serverless-example323"
   s3_key    = "v1.0.0/getfunction.zip"

   # "main" is the filename within the zip file (main.js) and "handler"
   # is the name of the property under which the handler function was
   # exported in that file.
   handler = "main.handler"
   runtime = "nodejs10.x"
   timeout          = "30"
   memory_size      = 256
   publish          = true

   vpc_config{
     subnet_ids = [var.subnet1id, var.subnet2id]
     security_group_ids = [var.securitygroupid]
   } 

   role = aws_iam_role.lambda_exec.arn

   tags = {
    Environment = var.environment
  }  
}

resource "aws_lambda_function" "postfunc" {
   function_name = "PostFunction"

   # The S3 bucket that contains the function code
   s3_bucket = "terraform-serverless-example323"
   s3_key    = "v1.0.0/postfunction.zip"

   # "main" is the filename within the zip file (main.js) and "handler"
   # is the name of the property under which the handler function was
   # exported in that file.
   handler = "main.handler"
   runtime = "nodejs10.x"
   timeout          = "30"
   memory_size      = 256
   publish          = true

   vpc_config{
     subnet_ids = [var.subnet1id, var.subnet2id]
     security_group_ids = [var.securitygroupid]
   } 

   role = aws_iam_role.lambda_exec.arn
   tags = {
    Environment = var.environment
  }  
}

# The IAM Policy that gives lambda access to other AWS services
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_exec.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}
 # IAM role which dictates what other AWS services the Lambda function
 # may access.
resource "aws_iam_role" "lambda_exec" {
   name = "LambdaRoleTerraform1"

   assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

