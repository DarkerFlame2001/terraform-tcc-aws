# 🚀 Contador de Acessos - Serverless AWS

> **Infraestrutura como Código para uma aplicação serverless de contador de acessos na AWS**

![Contador Banner](https://img.shields.io/badge/AWS-Serverless-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=for-the-badge&logo=python&logoColor=white)

---

## ✨ Funcionalidades

- **📊 Contador de Acessos** - Incrementa e consulta o número de acessos em tempo real
- **🔒 HTTPS Seguro** - Comunicação criptografada com certificado SSL/TLS via CloudFront
- **🔐 SSE-S3 (AES-256)** - Criptografia de arquivos em repouso no bucket S3
- **⚡ Escalabilidade Automática** - DynamoDB em modo PAY_PER_REQUEST escala sem intervenção
- **🛡️ Segurança em Camadas** - OAC, IAM com privilégios mínimos e Block Public Access
- **📱 Interface Responsiva** - Página HTML adaptada para desktop e dispositivos móveis
- **📊 Monitoramento** - Logs centralizados no CloudWatch para debugging e análise
- **🏗️ Infraestrutura como Código** - Toda infraestrutura versionada e reproduzível com Terraform

---

## 🛠️ Tecnologias

### AWS Services
| Serviço | Propósito |
|---------|-----------|
| **AWS CloudFront** | CDN + SSL/TLS para HTTPS |
| **AWS S3** | Armazenamento de arquivos estáticos |
| **AWS API Gateway** | Exposição de endpoints REST |
| **AWS Lambda** | Lógica de negócio (Python 3.12) |
| **Amazon DynamoDB** | Banco NoSQL serverless |
| **AWS IAM** | Gerenciamento de permissões |
| **AWS CloudWatch** | Logs e monitoramento |

### Tools
| Ferramenta | Versão | Propósito |
|------------|--------|-----------|
| **Terraform** | ≥ 1.0.0 | Infraestrutura como Código |
| **AWS CLI** | ≥ 2.0 | Interação com AWS |
| **Python** | 3.12 | Runtime da Lambda |
| **Boto3** | ≥ 1.34 | SDK AWS para Python |

---

## 🚀 Começando

### Pré-requisitos

- **Terraform** (v1.0+)
- **AWS CLI** (v2.0+)
- **Conta AWS** com credenciais configuradas
- **Python 3.12** (opcional, para testes locais)

### 📦 Instalação

#### Clonando o Repositório

```bash
git clone https://github.com/seu-usuario/contador-acessos.git
cd contador-acessos
code .
Configurando Credenciais AWS
bash
# Configure suas credenciais AWS
aws configure

# Preencha:
# AWS Access Key ID: SUA_ACCESS_KEY
# AWS Secret Access Key: SUA_SECRET_KEY
# Default region name: us-east-1
# Default output format: json

# Verifique se está configurado corretamente
aws sts get-caller-identity
Inicializando o Terraform
bash
# Instale os providers necessários
terraform init

# Valide a configuração
terraform validate

# Visualize o plano de execução
terraform plan
Deploy da Infraestrutura
bash
# Aplique a infraestrutura
terraform apply

# Digite "yes" quando confirmar
🖥️ Iniciando a Aplicação
Acessando o Site
bash
# Após o deploy, obtenha a URL do CloudFront
terraform output cloudfront_url

# Saída esperada:
# https://d1234567890abcdef.cloudfront.net
Abra a URL no seu navegador para ver o contador em ação! 🎉

Testando a API
bash
# Incrementar o contador (POST)
curl -X POST $(terraform output -raw contador_url_post)

# Consultar o contador (GET)
curl $(terraform output -raw contador_url_get)
🏗️ Arquitetura
Diagrama da Solução
text
┌─────────────────────────────────────────────────────────────────────────────┐
│                               USUÁRIO                                      │
│                                 │                                          │
│                                 │ 🔒 HTTPS (TLS 1.2+)                     │
│                                 ▼                                          │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    AWS CLOUDFRONT (CDN + SSL)                        │  │
│  │  • Distribuição de conteúdo global                                   │  │
│  │  • Certificado SSL gerenciado pela AWS                              │  │
│  │  • Redireciona HTTP → HTTPS                                         │  │
│  └────────────────────────────┬─────────────────────────────────────────┘  │
│                               │                                            │
│                               │ 🔒 OAC (Origin Access Control)            │
│                               ▼                                            │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    AMAZON S3 (ARMAZENAMENTO)                         │  │
│  │  • Arquivos estáticos (index.html)                                  │  │
│  │  • 🔒 SSE-S3 AES-256 (criptografia em repouso)                     │  │
│  │  • 🔒 Block Public Access (isolamento total)                       │  │
│  │  • 🔒 Bucket Policy (apenas CloudFront acessa)                     │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ════════════════════════════════════════════════════════════════════════  │
│                         API SERVERLESS                                     │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    AMAZON API GATEWAY (HTTP)                         │  │
│  │  • POST /contador → Incrementa contador                             │  │
│  │  • GET  /contador → Consulta contador                               │  │
│  │  • CORS habilitado                                                  │  │
│  └────────────────────────────┬─────────────────────────────────────────┘  │
│                               │                                            │
│                               │ 🔒 Invoca com permissões IAM              │
│                               ▼                                            │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    AWS LAMBDA (PYTHON 3.12)                          │  │
│  │  • Lógica de negócio do contador                                     │  │
│  │  • GET → Retorna valor atual                                        │  │
│  │  • POST → Incrementa atomicamente                                   │  │
│  │  • 🔒 IAM Role (privilégios mínimos)                                │  │
│  └────────────────────────────┬─────────────────────────────────────────┘  │
│                               │                                            │
│                               │ 🔒 Acesso via IAM                        │
│                               ▼                                            │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    AMAZON DYNAMODB (NOSQL)                           │  │
│  │  • Tabela: contador-acessos-dev                                     │  │
│  │  • Partition Key: id (hits)                                         │  │
│  │  • Billing: PAY_PER_REQUEST (escala automática)                     │  │
│  │  • Atomicidade: UpdateItem com if_not_exists                       │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │                    CLOUDWATCH LOGS (MONITORAMENTO)                   │  │
│  │  • Logs da Lambda                                                   │  │
│  │  • Access Logs do API Gateway                                       │  │
│  │  • Métricas e alarmes                                              │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
Fluxo da Aplicação
Usuário acessa o site via CloudFront (HTTPS)

Página HTML carrega e faz uma requisição GET para buscar o contador atual

Usuário clica no botão "Clique aqui"

JavaScript faz uma requisição POST para a API

API Gateway recebe a requisição e invoca a Lambda

Lambda atualiza o DynamoDB de forma atômica

Resposta retorna o novo valor para o frontend

Página atualiza o contador com animação

🔒 Segurança
Camada	Tecnologia	Descrição
🔒 Em trânsito	CloudFront + TLS 1.2+	Comunicação criptografada com HTTPS
🔒 Em repouso	SSE-S3 (AES-256)	Arquivos criptografados no S3
🔒 Acesso ao S3	OAC + Bucket Policy	Apenas CloudFront acessa o bucket
🔒 Isolamento	Block Public Access	Acesso público completamente bloqueado
🔒 Permissões	IAM Least Privilege	Lambda tem permissões mínimas
🔒 Atomicidade	DynamoDB UpdateItem	Evita race conditions
📊 Custo Estimado
Free Tier (12 meses)
Serviço	Free Tier	Projeto
Lambda	1M execuções/mês	✅ Dentro do limite
DynamoDB	25GB armazenamento	✅ Dentro do limite
API Gateway	1M requisições/mês	✅ Dentro do limite
CloudFront	1TB dados/mês	✅ Dentro do limite
S3	5GB armazenamento	✅ Dentro do limite
Custo Estimado Mensal
Para testes/estudo: ~US$ 0.00 (dentro do free tier)

Para produção baixo uso: ~US$ 2-5

Para produção alto uso: Escala linear com uso

📁 Estrutura do Projeto
text
contador-acessos/
│
├── 📄 main.tf                      # Provider AWS e configurações
├── 📄 variables.tf                 # Variáveis do projeto
├── 📄 outputs.tf                   # Saídas (URLs, nomes)
├── 📄 dynamodb.tf                  # Tabela DynamoDB
├── 📄 iam.tf                       # Roles e políticas IAM
├── 📄 lambda.tf                    # Função Lambda
├── 📄 api_gateway.tf               # API Gateway HTTP
├── 📄 cloudfront.tf                # CloudFront + OAC + HTTPS
├── 📄 s3_bucket.tf                 # Bucket S3 + bloqueios
├── 📄 s3_encryption.tf             # SSE-S3 (criptografia)
│
├── 📂 lambda_code/
│   └── 📄 contador.py              # Código Python da Lambda
│
├── 📄 index.html                   # Página HTML do contador
│
├── 📄 README.md                    # Documentação
└── 📄 .gitignore                   # Arquivos ignorados
🧹 Limpeza dos Recursos
bash
# Destrua toda a infraestrutura
terraform destroy

# Digite "yes" quando confirmar
🎓 Conceitos Abordados
✅ Infraestrutura como Código (IaC) com Terraform

✅ Arquitetura Serverless na AWS

✅ Segurança em camadas (defesa em profundidade)

✅ Criptografia em trânsito e em repouso

✅ Escalabilidade automática com serviços gerenciados

✅ Boas práticas de IAM (Least Privilege)

✅ Integração frontend-backend via API REST

✅ Atomicidade em operações de banco de dados

✅ Observabilidade com logs centralizados

✅ Custo otimizado com pay-per-use

🤝 Contribuindo
Contribuições são bem-vindas! Siga os passos:

Fork o projeto

Crie uma branch para sua feature

bash
git checkout -b feature/nova-feature
Commit suas mudanças

bash
git commit -m 'Adiciona nova feature'
Push para a branch

bash
git push origin feature/nova-feature
Abra um Pull Request

📝 Licença
Este projeto está sob a licença MIT - veja o arquivo LICENSE para detalhes.

📧 Contato
Guilherme - LinkedIn - GitHub

TCC - Arquitetura Serverless na AWS

🙏 Agradecimentos
AWS Academy - Suporte educacional

Orientadores - Pela orientação no TCC

Comunidade - DevOps e Serverless

📊 Badges
https://img.shields.io/github/stars/seu-usuario/contador-acessos
https://img.shields.io/github/forks/seu-usuario/contador-acessos
https://img.shields.io/github/issues/seu-usuario/contador-acessos
https://img.shields.io/github/last-commit/seu-usuario/contador-acessos
