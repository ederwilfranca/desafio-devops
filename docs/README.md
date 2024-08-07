# desafio-devops
# Aplicação Flask com Infraestrutura AWS

Este projeto demonstra uma infraestrutura escalável e observável para uma aplicação Flask usando vários serviços da AWS, 
como EKS, RDS, EC2, VPC, CloudFront e mais. O projeto inclui integração CI/CD com GitHub Actions.

## Estrutura do Projeto

- **app**: Contém o código da aplicação Flask.
- **ci_cd**: Arquivos de configuração para o pipeline CI/CD usando GitHub Actions.
- **infra**: Scripts Terraform para configurar a infraestrutura AWS.
- **k8s**: Manifests Kubernetes para deploy da aplicação.
- **logs**: Placeholder para logs da aplicação.
- **docs**: Arquivos de documentação.

## Primeiros Passos

Siga os guias fornecidos na pasta `docs` para configurar e fazer deploy do projeto.

1. [Guia de Implementação](docs/implementation_guide.md)
2. [Guia de CI/CD](docs/ci_cd_guide.md)

