# 👆 Contador de Acessos

> Uma aplicação serverless na AWS que conta cliques em tempo real

![AWS](https://img.shields.io/badge/AWS-Serverless-FF9900?style=flat-square&logo=amazon-aws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=flat-square&logo=terraform)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=flat-square&logo=python)

---

## 📋 Sobre o Projeto

Contador de acessos simples desenvolvido com arquitetura **serverless** na AWS. 

**Como funciona:**
1. Usuário acessa a página
2. Clica no botão
3. Contador aumenta e salva no banco

---

## 🛠️ Tecnologias

| Serviço | Função |
|---------|--------|
| **Terraform** | Infraestrutura como código |
| **AWS Lambda** | Lógica do contador (Python) |
| **API Gateway** | Endpoints da API |
| **DynamoDB** | Banco de dados NoSQL |
| **S3 + CloudFront** | Site + HTTPS |

---

## 🚀 Como Executar

# 1. Clone o repositório
git clone https://github.com/seu-usuario/contador-acessos.git
cd contador-acessos

# 2. Configure a AWS
aws configure

# 3. Inicie o Terraform
terraform init

# 4. Crie a infraestrutura
terraform apply

# 5. Pegue a URL do site
terraform output cloudfront_url
