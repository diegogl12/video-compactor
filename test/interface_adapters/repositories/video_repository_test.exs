defmodule VideoCompactor.InterfaceAdapters.Repositories.VideoRepositoryTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.InterfaceAdapters.Repositories.VideoRepository
  alias VideoCompactor.Domain.Entities.Video
  alias VideoCompactor.InterfaceAdapters.Repositories.Schemas.VideoSchema
  alias VideoCompactor.Infra.Repo.Mongo

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "create/1" do
    test "successfully creates a video" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}
      video_schema = %{id: video.id, zip_path: video.zip_path}

      VideoSchema
      |> stub(:new, fn ^video -> video_schema end)

      Mongo
      |> stub(:insert, fn ^video_schema -> {:ok, %{}} end)

      assert {:ok, ^video} = VideoRepository.create(video)
    end

    test "returns error when creation fails" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}
      video_schema = %{id: video.id, zip_path: video.zip_path}

      VideoSchema
      |> stub(:new, fn ^video -> video_schema end)

      Mongo
      |> stub(:insert, fn ^video_schema -> {:error, "Insertion Error"} end)

      assert {:error, "Insertion Error"} = VideoRepository.create(video)
    end
  end

  describe "update/1" do
    test "successfully updates a video" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}
      old_video_schema = %VideoSchema{id: video.id, zip_path: "old.zip", _id: 1}
      new_video_schema = %VideoSchema{id: video.id, zip_path: video.zip_path, _id: 1}
      result_video_schema = %VideoSchema{id: video.id, zip_path: video.zip_path, _id: 1}

      Mongo
      |> stub(:get_by, fn VideoSchema, %{id: id} when id == video.id -> old_video_schema end)
      |> stub(:update, fn ^new_video_schema -> {:ok, result_video_schema} end)

      assert {:ok, %Video{id: id, zip_path: zip_path}} = VideoRepository.update(video)
      assert id == video.id
      assert zip_path == video.zip_path
    end

    test "returns error when update fails" do
      video = %Video{id: "video-123", zip_path: "zip/video-123.zip"}
      old_video_schema = %VideoSchema{id: video.id, zip_path: "old.zip", _id: 1}
      new_video_schema = %VideoSchema{id: video.id, zip_path: video.zip_path, _id: 1}

      Mongo
      |> stub(:get_by, fn VideoSchema, %{id: id} when id == video.id -> old_video_schema end)
      |> stub(:update, fn ^new_video_schema -> {:error, "Update Error"} end)

      assert {:error, "Update Error"} = VideoRepository.update(video)
    end
  end

  describe "get_by_id/1" do
    test "successfully gets a video by id" do
      video_id = "video-123"
      video_schema = %{id: video_id, zip_path: "zip/video-123.zip"}

      Mongo
      |> stub(:get_by, fn VideoSchema, %{id: id} when id == video_id -> video_schema end)

      assert {:ok, %Video{id: id, zip_path: zip_path}} = VideoRepository.get_by_id(video_id)
      assert id == video_id
      assert zip_path == "zip/video-123.zip"
    end

    test "returns error when video is not found" do
      video_id = "video-123"

      Mongo
      |> stub(:get_by, fn VideoSchema, %{id: id} when id == video_id -> nil end)

      assert {:error, :not_found} = VideoRepository.get_by_id(video_id)
    end

    test "returns error when Mongo returns error" do
      video_id = "video-123"

      Mongo
      |> stub(:get_by, fn VideoSchema, %{id: id} when id == video_id ->
        {:error, "Mongo Error"}
      end)

      assert {:error, "Mongo Error"} = VideoRepository.get_by_id(video_id)
    end
  end
end
