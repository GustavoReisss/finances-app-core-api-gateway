# variable "env" {
#   type = string
# }

variable "region" {
  type    = string
  default = "sa-east-1"
}

variable "lambda_authorizer_name" {
  type    = string
  default = "lambda-session-authorizer"
}

# variable "api_gateway_id" {
#   type    = string
# }

# variable "api_gateway_execution_role_arn" {
#   type    = string
# }