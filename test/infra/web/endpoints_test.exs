defmodule VideoCompactor.Infra.Web.EndpointsTest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Mimic

  alias VideoCompactor.Infra.Web.Endpoints
  alias VideoCompactor.Infra.Web.Controllers.VideoController

  setup :set_mimic_global
  setup :verify_on_exit!

  @opts Endpoints.init([])

  describe "/api/health" do
    test "returns 200 and health message" do
      conn = conn(:get, "/api/health") |> Endpoints.call(@opts)
      assert conn.status == 200
      assert conn.resp_body == "Hello... All good!"
    end
  end

  describe "/api/video/info/:id" do
    test "returns 200 and video info on success" do
      video_info = %{id: "video-123", zip_path: "zip/video-123.zip"}
      VideoController |> stub(:get_video_info, fn "video-123" -> {:ok, video_info} end)
      conn = conn(:get, "/api/video/info/video-123") |> Endpoints.call(@opts)
      assert conn.status == 200

      assert Jason.decode!(conn.resp_body) == %{
               "id" => "video-123",
               "zip_path" => "zip/video-123.zip"
             }
    end

    test "returns 500 and error message on failure" do
      VideoController |> stub(:get_video_info, fn "video-404" -> {:error, :not_found} end)
      conn = conn(:get, "/api/video/info/video-404") |> Endpoints.call(@opts)
      assert conn.status == 500
      body = Jason.decode!(conn.resp_body)
      assert body["message"] =~ "Error getting video info"
      assert body["message"] =~ ":not_found"
    end
  end

  describe "404 route" do
    test "returns 404 for unknown route" do
      conn = conn(:get, "/unknown/path") |> Endpoints.call(@opts)
      assert conn.status == 404
      assert conn.resp_body == "Page not found"
    end
  end
end
