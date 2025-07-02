import Config

config :video_compactor, :api,
  port: System.get_env("VIDEO_COMPACTOR_ENDPOINT_PORT", "4000") |> String.to_integer()

config :tesla, adapter: {Tesla.Adapter.Hackney, [recv_timeout: 15_000]}

config :ex_aws, :s3,
  scheme: "http://",
  host: System.get_env("AWS_HOST"),
  port: System.get_env("AWS_PORT")

config :video_compactor, :s3, bucket_name: System.get_env("VIDEO_BUCKET_NAME", "video-compactor")

config :video_compactor, VideoCompactor.Infra.Repo.Mongo,
  url:
    "mongodb://#{System.get_env("VIDEO_COMPACTOR_MONGO_HOST")}:#{System.get_env("VIDEO_COMPACTOR_MONGO_PORT")}/video_compactor?authSource=admin",
  timeout: 60_000,
  idle_interval: 10_000,
  queue_target: 5_000

import_config "#{config_env()}.exs"
