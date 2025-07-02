defmodule VideoCompactor.Infra.Web.Controllers.VideoControllerTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.Infra.Web.Controllers.VideoController
  alias VideoCompactor.InterfaceAdapters.Controllers.VideoController, as: AdapterVideoController

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "get_video_info/1" do
    test "returns video info on success" do
      video_id = "video-123"
      video_info = %{id: video_id, zip_path: "zip/video-123.zip"}

      AdapterVideoController
      |> stub(:get_video_info, fn ^video_id -> {:ok, video_info} end)

      assert {:ok, ^video_info} = VideoController.get_video_info(video_id)
    end

    test "returns error when use case returns error" do
      video_id = "video-123"
      error = {:error, :not_found}

      AdapterVideoController
      |> stub(:get_video_info, fn ^video_id -> error end)

      assert ^error = VideoController.get_video_info(video_id)
    end
  end
end
