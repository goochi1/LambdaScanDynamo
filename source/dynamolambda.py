import json
import boto3
import os

def lambda_handler(event, context):
    tabel  = os.environ['TABEL']
    client = boto3.client('dynamodb')
    
    response = client.scan(
        TableName='%s' %tabel)


    txt = open("/tmp/dynamo.txt", "w")
    txt.write(str(response))

    txt.close()	
    
    #S3
    bucket = os.environ['BUCKET']
    s3 = boto3.resource('s3')
    s3.meta.client.upload_file('/tmp/dynamo.txt', '%s' %bucket, 'dynamo.csv') 