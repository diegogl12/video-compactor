message := '{"video_id": "1", "content": "test", "extension": "mp4"}'

queue_name := video_content

create_message:
	aws sqs send-message \
  	--endpoint-url http://localhost:4566 \
  	--queue-url "http://localhost:4566/000000000000/$(queue_name)" \
  	--message-body $(message)\
  	--region us-east-1 \
  	--profile localstack

up:
	docker-compose down -v
	docker-compose --env-file ./.env up --build