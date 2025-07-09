message := '{"Video_Id": "1", "File_Name": "123e4567-e89b-12d3-a456-426614174000", "Path": "http://localstack:4566/video-compactor/123e4567-e89b-12d3-a456-426614174000.mp4", "Extension": ".mp4"}'

queue_name := video_content

create_message:
	aws sqs send-message \
  	--endpoint-url http://localhost:4566 \
  	--queue-url "http://localhost:4566/000000000000/$(queue_name)" \
  	--message-body $(message)\
  	--region us-east-1 \
  	--profile localstack

upload_video:
	aws s3 cp ./test/test_utils/test_video.mp4 s3://video-compactor/video/video.mp4 \
	--endpoint-url http://localhost:4566 \
	--profile localstack \
	--region us-east-1

download_video:
	aws s3 cp s3://video-compactor/zip/123e4567-e89b-12d3-a456-426614174000.zip ./test.zip \
	--endpoint-url http://localhost:4566 \
	--profile localstack \
	--region us-east-1

up:
	docker-compose down -v
	docker-compose --env-file ./.env up --build