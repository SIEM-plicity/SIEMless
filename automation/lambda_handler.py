import json
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Received event: %s", json.dumps(event))
    try:
        s3 = boto3.client('s3')
        detail = event['detail']
        bucket = detail['requestParameters']['bucketName']
        key = detail['requestParameters']['key']
        logger.info(f"Processing file: s3://{bucket}/{key}")
        # TODO: Extend logic for parsing, Wazuh/OpenSearch forwarding
        return {"status": "success"}
    except Exception as e:
        logger.error("Error processing event: %s", e)
        raise
