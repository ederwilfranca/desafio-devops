import logging
import boto3
import time
from .config import Config

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

cloudwatch_logs = boto3.client('logs', region_name=Config.AWS_REGION)

def log_to_cloudwatch(new_comment):
    log_group_name = Config.CLOUDWATCH_LOG_GROUP
    log_stream_name = Config.CLOUDWATCH_LOG_STREAM
    log_message = f'Novo comentário adicionado: {new_comment}'

    try:
        response = cloudwatch_logs.put_log_events(
            logGroupName=log_group_name,
            logStreamName=log_stream_name,
            logEvents=[{'timestamp': int(round(time.time() * 1000)), 'message': log_message}]
        )
        logger.info(f'Log enviado para CloudWatch: {response}')
    except Exception as e:
        logger.error(f'Erro ao enviar log para CloudWatch: {str(e)}')
