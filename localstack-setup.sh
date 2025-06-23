#!/bin/bash

echo "Creating SQS..."

awslocal sqs create-queue --queue-name $VIDEO_CONTENT_SQS_NAME

