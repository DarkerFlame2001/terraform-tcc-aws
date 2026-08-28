# 📊 Contador de Acessos - Projeto Terraform AWS

> **Infraestrutura como Código para uma aplicação serverless de contador de acessos na AWS**

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Serverless-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

## 📋 Sobre o Projeto

Este projeto implementa um **contador de acessos serverless** na AWS utilizando **Terraform** para gerenciar toda a infraestrutura como código. Desenvolvido como Trabalho de Conclusão de Curso (TCC), demonstra conceitos modernos de arquitetura em nuvem, segurança e escalabilidade.

### 🎯 O que a aplicação faz?

- ✅ **Incrementa** um contador cada vez que um usuário clica no botão
- ✅ **Consulta** o valor atual do contador
- ✅ **Exibe** o contador em uma interface web amigável
- ✅ **Escala automaticamente** sem necessidade de configuração manual
- ✅ **Garante segurança** com HTTPS e criptografia de dados

### 🌟 Diferenciais do Projeto

| Característica | Benefício |
|----------------|-----------|
| **Serverless** | Sem servidores para gerenciar, paga apenas pelo uso |
| **Infraestrutura como Código** | Toda infraestrutura versionada e reproduzível |
| **Segurança em camadas** | HTTPS, SSE-S3, OAC, IAM com privilégios mínimos |
| **Escalabilidade automática** | DynamoDB PAY_PER_REQUEST escala sem intervenção |
| **Custo otimizado** | Free tier da AWS cobre todo o projeto |
| **Observabilidade** | Logs centralizados no CloudWatch |

---

## 🏗️ Arquitetura

### Diagrama da Solução
