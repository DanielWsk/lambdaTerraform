output "execution_arn"{
    value = aws_api_gateway_rest_api.example.execution_arn
}

output "base_url" {
  value = aws_api_gateway_deployment.example.invoke_url
}
