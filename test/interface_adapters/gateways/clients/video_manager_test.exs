defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManagerTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager
  alias VideoCompactor.Domain.Entities.Video

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "update_status/2" do
    test "returns :ok for 2xx response" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}

      Tesla
      |> stub(:put, fn _, _, _ -> {:ok, %{status: 200, body: ""}} end)
      |> stub(:client, fn _ -> [] end)

      assert :ok = VideoManager.update_status(video, "COMPACTED")
    end

    test "returns error for non-2xx response" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}

      Tesla
      |> stub(:put, fn _, _, _ -> {:ok, %{status: 400, body: "Bad Request"}} end)
      |> stub(:client, fn _ -> [] end)

      assert {:error, "Bad Request"} = VideoManager.update_status(video, "COMPACTED")
    end

    test "returns error for request failure" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}

      Tesla
      |> stub(:put, fn _, _, _ -> {:error, "Network Error"} end)
      |> stub(:client, fn _ -> [] end)

      assert {:error, "Network Error"} = VideoManager.update_status(video, "COMPACTED")
    end
  end
end
