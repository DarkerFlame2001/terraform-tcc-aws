variable "aws_region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Nome do projeto para naming dos recursos"
  type        = string
  default     = "contador-acessos"
}

variable "lambda_memory" {
  description = "Memória alocada para a função Lambda (MB)"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Timeout da função Lambda (segundos)"
  type        = number
  default     = 10
}