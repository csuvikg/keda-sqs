import os
import time

import boto3

queue_url = os.environ['SQS_QUEUE_URL']
sleep_seconds = float(os.environ['SLEEP_SECONDS'])

sqs = boto3.client('sqs')

counter = 1
while True:
    response = sqs.receive_message(
        QueueUrl=queue_url,
        MaxNumberOfMessages=1,
        VisibilityTimeout=1,
        WaitTimeSeconds=0
    )

    if 'Messages' in response:
        message = response['Messages'][0]
        receipt_handle = message['ReceiptHandle']

        sqs.delete_message(
            QueueUrl=queue_url,
            ReceiptHandle=receipt_handle
        )
        print(f"Received and deleted message: {message['Body']}")

    time.sleep(sleep_seconds)
