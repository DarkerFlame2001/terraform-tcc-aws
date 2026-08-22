resource "aws_dynamodb_table" "contador" {
  name           = "${var.project_name}-${var.environment}"
  billing_mode   = "PAY_PER_REQUEST"  # Escala automaticamente, paga só pelo uso
  hash_key       = "id"               # Partition Key

  attribute {
    name = "id"
    type = "S"  # String
  }

  # Proteção contra exclusão acidental em produção
  deletion_protection_enabled = var.environment == "prod" ? true : false

  tags = {
    Name = "${var.project_name}-table"
  }
}

# Inicializa o contador com valor 0
resource "aws_dynamodb_table_item" "contador_inicial" {
  table_name = aws_dynamodb_table.contador.name
  hash_key   = aws_dynamodb_table.contador.hash_key

  item = jsonencode({
    "id"    = { "S" = "hits" }
    "count" = { "N" = "0" }
  })

  lifecycle {
    ignore_changes = [item]  # Não sobrescreve após criação inicial
  }
}