import Config

config :video_compactor, :sqs,
  video_content: [
    host: System.get_env("AWS_ENDPOINT"),
    name: System.get_env("VIDEO_CONTENT_SQS_NAME")
  ]

config :video_compactor, :aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION"),
  endpoint: System.get_env("AWS_ENDPOINT"),
  account_id: System.get_env("AWS_ACCOUNT_ID"),
  sqs_host: System.get_env("AWS_SQS_HOST"),
  sqs_port: System.get_env("AWS_SQS_PORT")

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  region: System.get_env("AWS_REGION"),
  http_client: ExAws.Request.Hackney

config :video_compactor, :video_manager,
  host: System.get_env("VIDEO_MANAGER_HOST")
