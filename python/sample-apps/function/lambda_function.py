import os
import json
import requests
import boto3

client = boto3.client("s3")

# lambda function
def lambda_handler(event, context):

    requests.get("https://aws.amazon.com/")

    client.list_buckets()

    return {"body": os.environ.get("_X_AMZN_TRACE_ID")}
