resource "aws_apigatewayv2_stage" "api_stage" {
  api_id = aws_apigatewayv2_api.api_gateway.id
  name   = "api" # the same name as the behavior set on cloudfront
  auto_deploy = true
}