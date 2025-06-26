#!/bin/bash

echo "Creating SQS..."

awslocal sqs create-queue --queue-name $VIDEO_CONTENT_SQS_NAME

echo "Creating S3 bucket..."
awslocal s3 mb s3://$VIDEO_BUCKET_NAME
