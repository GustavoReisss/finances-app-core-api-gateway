output "lambda_invoke_arn" {
  value = aws_lambda_function.authorizer.invoke_arn
}