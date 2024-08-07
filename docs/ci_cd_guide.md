
### docs/ci_cd_guide.md

# Guia de CI/CD

Este guia fornece instruções para configurar CI/CD para a aplicação Flask usando GitHub Actions.

## Pré-requisitos

Certifique-se de ter o seguinte:

- Conta no GitHub
- Repositório para o projeto
- GitHub Actions configurado

## Passo 1: Criar Segredos no GitHub

1. Navegue para o seu repositório no GitHub.
2. Vá para **Settings** > **Secrets and variables** > **Actions**.
3. Adicione os seguintes segredos:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `ECR_REGISTRY`
   - `AWS_REGION`
   - `KUBECONFIG`

## Passo 2: Configurar o Workflow do GitHub Actions

1. Certifique-se de que o arquivo de workflow está localizado em `.github/workflows/ci_cd.yml`.


```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.9'

    - name: Install dependencies
      run: |
        pip install -r app/requirements.txt

    - name: Lint with flake8
      run: |
        pip install flake8
        flake8 app/*.py

    - name: Build Docker image
      run: |
        docker build -t flask-app:latest app/

    - name: Log in to Amazon ECR
      env:
        AWS_REGION: ${{ secrets.AWS_REGION }}
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      run: |
        $(aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY)

    - name: Tag and Push Docker image
      env:
        ECR_REGISTRY: ${{ secrets.ECR_REGISTRY }}
        AWS_REGION: ${{ secrets.AWS_REGION }}
        IMAGE_REPO_NAME: "flask-app-repo"
      run: |
        docker tag flask-app:latest $ECR_REGISTRY/$IMAGE_REPO_NAME:latest
        docker push $ECR_REGISTRY/$IMAGE_REPO_NAME:latest

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up kubectl
      uses: azure/setup-kubectl@v1
      with:
        version: '1.21.0'

    - name: Deploy to EKS
      env:
        KUBECONFIG: ${{ secrets.KUBECONFIG }}
      run: |
        kubectl apply -f k8s/deployment.yaml
        kubectl apply -f k8s/service.yaml
        kubectl apply -f k8s/configmap.yaml

    - name: Notify Deployment
      run: echo "Deploy para EKS concluído com sucesso!"
