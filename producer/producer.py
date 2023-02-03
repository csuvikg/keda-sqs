import os
import time

import boto3

queue_url = os.environ['SQS_QUEUE_URL']
message_group_id = os.environ['SQS_MESSAGE_GROUP_ID']
sleep_seconds = float(os.environ['SLEEP_SECONDS'])

sqs = boto3.client('sqs')

counter = 1
while True:
    response = sqs.send_message(
        QueueUrl=queue_url,
        MessageGroupId=message_group_id,
        MessageBody=f"{counter}"
    )
    print(f"Sent message: {counter}")
    counter += 1

    time.sleep(sleep_seconds)
