
# CREATED ON API GATEWAY TEMPLATE YAML
# resource "aws_apigatewayv2_authorizer" "session_authorizer" {
#   name                   = "session_authorizer"
#   api_id                 = var.api_gateway_id
#   authorizer_uri         = aws_lambda_function.authorizer.invoke_arn
#   authorizer_credentials_arn = var.api_gateway_execution_role_arn
#   enable_simple_responses = true

#   authorizer_type  = "REQUEST"
#   identity_sources = ["$request.header.Cookie"]
#   authorizer_payload_format_version = "2.0"
# }

resource "aws_lambda_function" "authorizer" {
  function_name =   var.lambda_authorizer_name
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  role          = aws_iam_role.lambda_authorizer_role.arn
  filename         = data.archive_file.code.output_path
  source_code_hash = data.archive_file.code.output_base64sha256
  layers           = [aws_lambda_layer_version.requirements_lambda_layer.arn]
  timeout          = 29

  environment {
    variables = {
      "ENV" = "dev"
    }
  } 
}

 
data "archive_file" "code" {
  type        = "zip"
  source_dir  = "${local.source_code_path}"
  excludes    = ["venv"]
  output_path = "${path.module}/outputs/code.zip"
}