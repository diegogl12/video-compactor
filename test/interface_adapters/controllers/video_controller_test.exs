defmodule VideoCompactor.InterfaceAdapters.Controllers.VideoControllerTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.InterfaceAdapters.Controllers.VideoController
  alias VideoCompactor.InterfaceAdapters.Repositories.VideoRepository
  alias VideoCompactor.InterfaceAdapters.DTOs.WebVideoResponseDTO
  alias VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTO
  alias VideoCompactor.UseCases.CompactVideo
  alias VideoCompactor.Domain.Entities.Video

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "get_video_info/1" do
    test "returns video info on success" do
      video_id = "video-123"
      video = %Video{id: video_id, zip_path: "zip/video-123.zip"}
      video_info = %{id: video_id, zip_path: "zip/video-123.zip"}

      VideoRepository
      |> stub(:get_by_id, fn ^video_id -> {:ok, video} end)

      WebVideoResponseDTO
      |> stub(:from_domain, fn ^video -> {:ok, video_info} end)

      assert {:ok, ^video_info} = VideoController.get_video_info(video_id)
    end

    test "returns error when repository returns error" do
      video_id = "video-123"
      error = {:error, :not_found}

      VideoRepository
      |> stub(:get_by_id, fn ^video_id -> error end)

      assert {:error, ^error} = VideoController.get_video_info(video_id)
    end

    test "returns error when DTO conversion fails" do
      video_id = "video-123"
      video = %Video{id: video_id, zip_path: "zip/video-123.zip"}
      error = {:error, :invalid_dto}

      VideoRepository
      |> stub(:get_by_id, fn ^video_id -> {:ok, video} end)

      WebVideoResponseDTO
      |> stub(:from_domain, fn ^video -> error end)

      assert {:error, ^error} = VideoController.get_video_info(video_id)
    end
  end

  describe "compact_video/1" do
    test "returns ok on success" do
      raw_event = "{\"video_id\":\"video-123\"}"
      event_dto = %{video_id: "video-123", path: "some/path", extension: "mp4"}
      video = %Video{id: "video-123", temp_file_path: "some/path", extension: "mp4"}

      VideoContentEventDTO
      |> stub(:from_json, fn ^raw_event -> {:ok, event_dto} end)
      |> stub(:to_domain, fn ^event_dto -> {:ok, video} end)

      CompactVideo
      |> stub(:run, fn ^video, _, _, _, _ -> :ok end)

      assert {:ok, %{}} = VideoController.compact_video(raw_event)
    end

    test "returns error when from_json fails" do
      raw_event = "{\"video_id\":\"video-123\"}"
      error = {:error, :invalid_json}

      VideoContentEventDTO
      |> stub(:from_json, fn ^raw_event -> error end)

      assert {:error, ^error} = VideoController.compact_video(raw_event)
    end

    test "returns error when to_domain fails" do
      raw_event = "{\"video_id\":\"video-123\"}"
      event_dto = %{video_id: "video-123", path: "some/path", extension: "mp4"}
      error = {:error, :invalid_domain}

      VideoContentEventDTO
      |> stub(:from_json, fn ^raw_event -> {:ok, event_dto} end)
      |> stub(:to_domain, fn ^event_dto -> error end)

      assert {:error, ^error} = VideoController.compact_video(raw_event)
    end

    test "returns error when CompactVideo.run fails" do
      raw_event = "{\"video_id\":\"video-123\"}"
      event_dto = %{video_id: "video-123", path: "some/path", extension: "mp4"}
      video = %Video{id: "video-123", temp_file_path: "some/path", extension: "mp4"}
      error = {:error, :compaction_failed}

      VideoContentEventDTO
      |> stub(:from_json, fn ^raw_event -> {:ok, event_dto} end)
      |> stub(:to_domain, fn ^event_dto -> {:ok, video} end)

      CompactVideo
      |> stub(:run, fn ^video, _, _, _, _ -> error end)

      assert {:error, ^error} = VideoController.compact_video(raw_event)
    end
  end
end
