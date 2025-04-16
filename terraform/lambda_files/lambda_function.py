import json
import boto3

print('Loading function')

def lambda_handler(event, context):
    print("Hello world!")
    return {
        'statusCode': 200,
        'body': 'Hello world!'
    }
