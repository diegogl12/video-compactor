defmodule VideoCompactor.Infra.Web.Endpoints do
  use Plug.Router
  require Logger

  alias VideoCompactor.Infra.Web.Controllers.VideoController

  plug(:match)

  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)

  plug(:dispatch)

  get "/api/health" do
    send_resp(conn, 200, "Hello... All good!")
  end

  get "/api/video/info/:id" do
    case VideoController.get_video_info(conn.params["id"]) do
      {:ok, video_info} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(video_info))

      {:error, error} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          500,
          Jason.encode!(%{message: "Error getting video info: #{inspect(error)}"})
        )
    end
  end

  match _ do
    send_resp(conn, 404, "Page not found")
  end
end
