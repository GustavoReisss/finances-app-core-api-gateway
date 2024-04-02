# variable "env" {
#   type = string
# }

variable "region" {
  type    = string
  default = "sa-east-1"
}

variable "lambda_authorizer_invoke_arn" {
  type    = string
}
