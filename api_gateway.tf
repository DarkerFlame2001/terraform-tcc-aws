# API HTTP (mais simples e barata que REST API)
resource "aws_apigatewayv2_api" "contador" {
  name          = "${var.project_name}-api-${var.environment}"
  protocol_type = "HTTP"

  cors_configuration {
    allow_headers = ["Content-Type", "Authorization"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_origins = ["*"]  # Em produção, restrinja ao domínio da landing page
    max_age       = 300
  }

  tags = {
    Name = "${var.project_name}-api"
  }
}

# Integração com Lambda
resource "aws_apigatewayv2_integration" "lambda" {
  api_id             = aws_apigatewayv2_api.contador.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.contador.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

# Rota POST /contador (incrementa e retorna o valor)
resource "aws_apigatewayv2_route" "post_contador" {
  api_id    = aws_apigatewayv2_api.contador.id
  route_key = "POST /contador"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# Rota GET /contador (apenas consulta o valor atual)
resource "aws_apigatewayv2_route" "get_contador" {
  api_id    = aws_apigatewayv2_api.contador.id
  route_key = "GET /contador"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# Stage de deploy
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.contador.id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format = jsonencode({
      requestId    = "$context.requestId"
      ip           = "$context.identity.sourceIp"
      requestTime  = "$context.requestTime"
      httpMethod   = "$context.httpMethod"
      routeKey     = "$context.routeKey"
      status       = "$context.status"
      responseLength = "$context.responseLength"
    })
  }
}

# Log group para API Gateway
resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/api-gateway/${var.project_name}-${var.environment}"
  retention_in_days = 14
}