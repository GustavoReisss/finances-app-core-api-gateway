resource "aws_iam_role" "execution_role" {
  name                = "api-gateway-core-execution-role"

  managed_policy_arns = [
    aws_iam_policy.execution_policy.arn
  ]

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Sid    = ""
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "execution_policy" {
  name        = "api-gateway-core-execution-policy"
  path        = "/"
  description = "Grant access for API Gateway to invoke other services"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}