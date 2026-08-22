# Empacota o código Python em ZIP
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code/contador.py"
  output_path = "${path.module}/lambda_code/contador.zip"
}

# Função Lambda
resource "aws_lambda_function" "contador" {
  function_name    = "${var.project_name}-${var.environment}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "contador.lambda_handler"
  runtime          = "python3.12"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  memory_size      = var.lambda_memory
  timeout          = var.lambda_timeout

  environment {
    variables = {
      TABLE_NAME  = aws_dynamodb_table.contador.name
      COUNTER_ID  = "hits"
    }
  }

  tags = {
    Name = "${var.project_name}-lambda"
  }
}

# Permissão para API Gateway invocar a Lambda
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.contador.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.contador.execution_arn}/*/*"
}