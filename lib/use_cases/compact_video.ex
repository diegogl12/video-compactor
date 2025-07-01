defmodule VideoCompactor.UseCases.CompactVideo do
  require Logger
  alias VideoCompactor.Domain.Entities.Video

  @zip_local_path "./zip"
  @tmp_local_path "./tmp"

  @status_compacted "COMPACTED"
  @status_error "ERROR"

  def run(%Video{} = video, repository, video_manager, s3_client, video_splitter) do
    temp_video_file_name = "#{video.id}.#{video.extension}"
    temp_video_local_path = "#{@tmp_local_path}/#{temp_video_file_name}"
    temp_video_split_local_path = "#{@tmp_local_path}/#{video.id}/frame_%04d.png"
    temp_video_splited_local_path = "#{video.id}/"
    temp_zip_local_path = "#{@zip_local_path}/#{video.id}.zip"
    bucket_zip_path = "zip/#{video.id}.zip"

    with :ok <- s3_client.download_file(video.temp_file_path, temp_video_local_path),
          :ok <- File.mkdir_p(@tmp_local_path <> "/" <> video.id <> "/"),
          :ok <- video_splitter.split_video(temp_video_local_path, temp_video_split_local_path),
          charlist_video_splited <- String.to_charlist(temp_video_splited_local_path),
          charlist_temp_cwd <- String.to_charlist(@tmp_local_path),
          {:ok, _} <- :zip.create(temp_zip_local_path, [charlist_video_splited], cwd: charlist_temp_cwd),
          :ok <- s3_client.upload_file(bucket_zip_path, temp_zip_local_path),
          video <- %{video | zip_path: bucket_zip_path},
          {:ok, _} <- repository.create(video),
          :ok <- video_manager.update_status(video, @status_compacted),
          :ok <- File.rm(temp_zip_local_path),
          :ok <- File.rm(temp_video_local_path),
          {:ok, _} <- File.rm_rf(@tmp_local_path <> "/" <> video.id <> "/") do
      Logger.info("Zip path: #{inspect(bucket_zip_path)}")
      :ok
    else
      error ->
        Logger.error("Error compacting video: #{inspect(error)}")
        video_manager.update_status(video, @status_error)
        {:error, error}
    end
  end
end
