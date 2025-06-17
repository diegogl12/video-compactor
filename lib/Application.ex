defmodule VideoCompactor.Application do
  use Application
  require Logger

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: VideoCompactor.Supervisor]

    Logger.info("The server has started at port #{port()}...")

    Supervisor.start_link(children(Mix.env()), opts)
  end

  defp children(:test), do: []
  defp children(_), do: [
    {Plug.Cowboy, scheme: :http, plug: VideoCompactor.Infra.Web.Endpoints, options: [port: port()]},
    {VideoCompactor.Infra.Consumers.Broadway, [queue_name: :video_content]},
    VideoCompactor.Infra.Repo.Mongo
  ]

  defp port, do: Application.get_env(:video_compactor, :api) |> Keyword.get(:port)
end
