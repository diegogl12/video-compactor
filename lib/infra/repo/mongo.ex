defmodule VideoCompactor.Infra.Repo.Mongo do
  use Mongo.Repo,
    otp_app: :video_compactor,
    topology: :mongo
end
