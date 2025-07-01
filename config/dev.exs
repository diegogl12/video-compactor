import Config

config :video_compactor, :api,
  port: System.get_env("VIDEO_COMPACTOR_ENDPOINT_PORT", "4000") |> String.to_integer()

config :video_compactor, :s3, bucket_name: System.get_env("VIDEO_BUCKET_NAME")
