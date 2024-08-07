# Guia de Implementação

Este guia fornece instruções passo a passo para configurar e fazer o deploy da aplicação Flask usando serviços da AWS.

## Pré-requisitos

Certifique-se de ter o seguinte instalado e configurado:

- Conta AWS
- AWS CLI configurado com suas credenciais
- Terraform instalado
- Docker instalado
- kubectl instalado
- Conta no GitHub

### Verificando e Instalando Pré-requisitos

#### AWS CLI

Para instalar o AWS CLI, siga as instruções no site oficial da AWS: [Instalar AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

1. Após a instalação, configure suas credenciais AWS:

   ```sh
   aws configure

2. Terraform
Para instalar o Terraform, siga as instruções no site oficial do Terraform: Instalar Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

3. Verifique a instalação:

    sh terraform -v

4. Docker
Para instalar o Docker, siga as instruções no site oficial do Docker: Instalar Docker https://docs.docker.com/engine/install/ubuntu/

Verifique a instalação:

    sh docker --version

5. kubectl
Para instalar o kubectl, siga as instruções no site oficial do Kubernetes: Instalar kubectl https://kubernetes.io/pt-br/docs/tasks/tools/install-kubectl-linux/

Verifique a instalação:

    sh kubectl version --client

Passo 1: Configurar a Infraestrutura
1.1 Clonar o Repositório
Clone o repositório do projeto para sua máquina local:

    sh git clone https://github.com/ederwilfranca/desafio-devops.git
    cd desafio-devops

1.2 Configurar AWS CLI
Certifique-se de que seu AWS CLI está configurado com as credenciais e região necessárias:

    sh aws configure

1.3 Configurar Terraform
    1. Navegue para o diretório Terraform:
    
        sh cd terraform 
    
    2. Inicialize o Terraform 
        sh terraform init
    
    3. Aplique a configuração do Terraform para criar a infraestrutura:
        sh terraform apply
        Revise o plano e confirme a aplicação digitando yes.

1.4 Verificar Infraestrutura
Após o Terraform concluir, verifique a configuração da infraestrutura no Console de Gerenciamento da AWS para os seguintes recursos:

    VPC
    Cluster EKS
    Instância RDS
    Repositório ECR
    Bucket S3

Passo 2: Construir e Enviar Imagem Docker
2.1 Construir a Imagem Docker
    
    Navegue para o diretório app:
        sh cd ../app
    
    Construa a imagem Docker:
        sh docker build -t flask-app:latest .

2.2 Enviar a Imagem Docker para o ECR

    Autentique o Docker no AWS ECR:
        sh $(aws ecr get-login --no-include-email --region us-east-1)
    
    Marque a imagem Docker:
        sh docker tag flask-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/desafio-devops-repo:latest
    
    Envie a imagem Docker para o ECR:
        sh docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/desafio-devops-repo:latest

Passo 3: Fazer Deploy da Aplicação no EKS
3.1 Configurar kubectl
    
    Atualize seu kubeconfig para usar o cluster EKS:
        sh  aws eks --region us-east-1 update-kubeconfig --name desafio-devops-cluster

3.2 Aplicar Manifests Kubernetes
    
    Navegue para o diretório k8s:
        sh cd ../k8s
    
    Aplique os manifests Kubernetes:
        sh kubectl apply -f deployment.yaml
           kubectl apply -f service.yaml
           kubectl apply -f database_service.yaml

Passo 4: Acessar a Aplicação
4.1 Recuperar o DNS do Load Balancer
    
    Obtenha o nome DNS do Load Balancer:
        sh kubectl get svc desafio-devops -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
