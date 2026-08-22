output "api_endpoint" {
  description = "URL base da API Gateway"
  value       = aws_apigatewayv2_api.contador.api_endpoint
}

output "contador_url_post" {
  description = "URL para incrementar o contador (POST)"
  value       = "${aws_apigatewayv2_api.contador.api_endpoint}/contador"
}

output "contador_url_get" {
  description = "URL para consultar o contador (GET)"
  value       = "${aws_apigatewayv2_api.contador.api_endpoint}/contador"
}

output "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB"
  value       = aws_dynamodb_table.contador.name
}

output "lambda_function_name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.contador.function_name
}