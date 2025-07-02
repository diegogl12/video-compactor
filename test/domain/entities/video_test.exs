defmodule VideoCompactor.Domain.Entities.VideoTest do
  use ExUnit.Case, async: true

  alias VideoCompactor.Domain.Entities.Video

  describe "struct and type" do
    test "default struct values are nil" do
      video = %Video{}
      assert video.id == nil
      assert video.temp_file_path == nil
      assert video.zip_path == nil
      assert video.status == nil
      assert video.extension == nil
    end
  end

  describe "new/1" do
    test "creates a video struct from a map with all fields" do
      attrs = %{
        id: "video-123",
        temp_file_path: "/tmp/video-123.mp4",
        zip_path: "zip/video-123.zip",
        status: "COMPACTED",
        extension: "mp4"
      }
      assert {:ok, %Video{} = video} = Video.new(attrs)
      assert video.id == "video-123"
      assert video.temp_file_path == "/tmp/video-123.mp4"
      assert video.zip_path == "zip/video-123.zip"
      assert video.status == "COMPACTED"
      assert video.extension == "mp4"
    end

    test "creates a video struct from a map with partial fields" do
      attrs = %{id: "video-456"}
      assert {:ok, %Video{} = video} = Video.new(attrs)
      assert video.id == "video-456"
      assert video.temp_file_path == nil
      assert video.zip_path == nil
      assert video.status == nil
      assert video.extension == nil
    end
  end
end
