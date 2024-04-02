resource "aws_apigatewayv2_api" "api_gateway" {
  name        = "finances-app-core-api-gateway"
  protocol_type = "HTTP"
  description = "API Gateway to handle REST Backend Requests for finances-app"
  
  body        = data.template_file.api_template.rendered
}

data "template_file" "api_template" {
  template = file("${path.module}/api_template.yaml")

  vars = {
    aws_region     = var.region
    execution_role = aws_iam_role.execution_role.arn
    aws_account_id = data.aws_caller_identity.current.account_id
    lambda_authorizer_invoke_arn = var.lambda_authorizer_invoke_arn
  }

}