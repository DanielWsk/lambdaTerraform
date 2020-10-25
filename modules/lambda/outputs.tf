output "lambda_uri"{
    value = aws_lambda_function.getfunc.invoke_arn
}

output "lambda_root_uri"{
    value = aws_lambda_function.postfunc.invoke_arn
}

output "getfuncname"{
    value = aws_lambda_function.getfunc.function_name
}

output "postfuncname"{
    value = aws_lambda_function.postfunc.function_name
}