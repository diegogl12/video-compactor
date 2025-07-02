defmodule VideoCompactor.UseCases.CompactVideoTest do
  use ExUnit.Case, async: false
  use Mimic

  alias VideoCompactor.UseCases.CompactVideo
  alias VideoCompactor.Domain.Entities.Video

  setup :set_mimic_global
  setup :verify_on_exit!

  setup do
    repository = VideoCompactor.InterfaceAdapters.Repositories.VideoRepository
    video_manager = VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager
    s3_client = VideoCompactor.InterfaceAdapters.Gateways.Clients.S3
    video_splitter = VideoCompactor.InterfaceAdapters.Gateways.Clients.Ffmpex

    {:ok,
     repository: repository,
     video_manager: video_manager,
     s3_client: s3_client,
     video_splitter: video_splitter}
  end

  describe "run/5" do
    test "should compact video", %{
      repository: repository,
      video_manager: video_manager,
      s3_client: s3_client,
      video_splitter: video_splitter
    } do
      File.mkdir_p("./tmp/")

      video = %Video{
        id: "123e4567-e89b-12d3-a456-426614174000",
        temp_file_path: "video/123e4567-e89b-12d3-a456-426614174000.mp4",
        extension: "mp4"
      }

      s3_client
      |> stub(:download_file, fn _, _ ->
        true = File.exists?("./test/test_utils/test_video.mp4")

        System.cmd("cp", [
          "-r",
          "./test/test_utils/test_video.mp4",
          "./tmp/123e4567-e89b-12d3-a456-426614174000.mp4"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000.mp4")

        :ok
      end)

      video_splitter
      |> stub(:split_video, fn _, _ ->
        System.cmd("cp", [
          "-r",
          "./test/test_utils/123e4567-e89b-12d3-a456-426614174000/.",
          "./tmp/123e4567-e89b-12d3-a456-426614174000/"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0001.png")
        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0002.png")

        :ok
      end)

      s3_client |> stub(:upload_file, fn _, _ -> :ok end)
      repository |> stub(:create, fn _ -> {:ok, video} end)
      video_manager |> stub(:update_status, fn _, _ -> :ok end)

      assert :ok = CompactVideo.run(video, repository, video_manager, s3_client, video_splitter)

      File.rm_rf("./tmp/")
    end

    test "should return error when video_splitter returns error", %{
      video: video,
      repository: repository,
      video_manager: video_manager,
      s3_client: s3_client,
      video_splitter: video_splitter
    } do
      File.mkdir_p("./tmp/")
      s3_client |> stub(:download_file, fn _, _ -> :ok end)
      File |> stub(:mkdir_p, fn _ -> :ok end)
      video_splitter |> stub(:split_video, fn _, _ -> {:error, "split error"} end)
      video_manager |> stub(:update_status, fn _, _ -> :ok end)

      assert {:error, {:error, "split error"}} =
               CompactVideo.run(video, repository, video_manager, s3_client, video_splitter)

      File.rm_rf("./tmp/")
    end

    test "should return error when repository.create returns error", %{
      repository: repository,
      video_manager: video_manager,
      s3_client: s3_client,
      video_splitter: video_splitter
    } do
      File.mkdir_p("./tmp/")

      video = %Video{
        id: "123e4567-e89b-12d3-a456-426614174000",
        temp_file_path: "video/123e4567-e89b-12d3-a456-426614174000.mp4",
        extension: "mp4"
      }

      s3_client
      |> stub(:download_file, fn _, _ ->
        true = File.exists?("./test/test_utils/test_video.mp4")

        System.cmd("cp", [
          "-r",
          "./test/test_utils/test_video.mp4",
          "./tmp/123e4567-e89b-12d3-a456-426614174000.mp4"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000.mp4")

        :ok
      end)

      video_splitter
      |> stub(:split_video, fn _, _ ->
        System.cmd("cp", [
          "-r",
          "./test/test_utils/123e4567-e89b-12d3-a456-426614174000/.",
          "./tmp/123e4567-e89b-12d3-a456-426614174000/"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0001.png")
        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0002.png")

        :ok
      end)

      s3_client |> stub(:upload_file, fn _, _ -> :ok end)
      repository |> stub(:create, fn _ -> {:error, "repo error"} end)
      video_manager |> stub(:update_status, fn _, _ -> :ok end)

      assert {:error, {:error, "repo error"}} =
               CompactVideo.run(video, repository, video_manager, s3_client, video_splitter)

      File.rm_rf("./tmp/")
    end

    test "should return error when video_manager returns error", %{
      repository: repository,
      video_manager: video_manager,
      s3_client: s3_client,
      video_splitter: video_splitter
    } do
      File.mkdir_p("./tmp/")

      video = %Video{
        id: "123e4567-e89b-12d3-a456-426614174000",
        temp_file_path: "video/123e4567-e89b-12d3-a456-426614174000.mp4",
        extension: "mp4"
      }

      s3_client
      |> stub(:download_file, fn _, _ ->
        true = File.exists?("./test/test_utils/test_video.mp4")

        System.cmd("cp", [
          "-r",
          "./test/test_utils/test_video.mp4",
          "./tmp/123e4567-e89b-12d3-a456-426614174000.mp4"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000.mp4")

        :ok
      end)

      video_splitter
      |> stub(:split_video, fn _, _ ->
        System.cmd("cp", [
          "-r",
          "./test/test_utils/123e4567-e89b-12d3-a456-426614174000/.",
          "./tmp/123e4567-e89b-12d3-a456-426614174000/"
        ])

        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0001.png")
        assert File.exists?("./tmp/123e4567-e89b-12d3-a456-426614174000/frame_0002.png")

        :ok
      end)

      s3_client |> stub(:upload_file, fn _, _ -> :ok end)
      repository |> stub(:create, fn _ -> {:ok, video} end)
      video_manager |> stub(:update_status, fn _, _ -> {:error, "manager error"} end)

      assert {:error, {:error, "manager error"}} =
               CompactVideo.run(video, repository, video_manager, s3_client, video_splitter)

      File.rm_rf("./tmp/")
    end
  end
end
