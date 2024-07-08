import os

class Config:
    DEBUG = True
    CLOUDWATCH_LOG_GROUP = '/aws/eks/cluster/flask-app-cluster'
    CLOUDWATCH_LOG_STREAM = 'flask-app-logs'
    AWS_REGION = 'us-west-2'
    DB_USER = os.getenv('DB_USER', 'admin')
    DB_PASSWORD = os.getenv('DB_PASSWORD', 'password')
    DB_NAME = os.getenv('DB_NAME', 'flaskappdb')
    DB_HOST = os.getenv('DB_HOST', 'localhost')
    DB_PORT = os.getenv('DB_PORT', 5432)
