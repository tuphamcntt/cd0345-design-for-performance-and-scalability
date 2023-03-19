# Output variable for the lambda function.
output "lambda_function_name" {
  value = aws_lambda_function.greet_lambda.function_name
}

output "lambda_function_arn" {
  value = aws_lambda_function.greet_lambda.arn
}

output "lambda_function_runtime" {
  value = aws_lambda_function.greet_lambda.runtime
}