defmodule VideoCompactor.UseCases.VideoCompactor do
  require Logger
  alias VideoCompactor.Domain.Entities.Video

  @zip_path "/tmp/zip"
  @tmp_path "/tmp"

  @status_compacted "COMPACTED"
  @status_error "ERROR"

  def run(%Video{} = video, repository, video_manager) do
    with charlist_path <- String.to_charlist("#{@tmp_path}/#{video.temp_file_path}"),
         {:ok, zip_path} <- :zip.create("#{@zip_path}/#{video.id}.zip", [charlist_path]),
         {:ok, _} <- repository.create(%{video | zip_path: zip_path}),
         :ok <- video_manager.update_status(video, @status_compacted) do
      Logger.info("Zip path: #{inspect(zip_path)}")
      :ok
    else
      error ->
        Logger.error("Error compacting video: #{inspect(error)}")
        video_manager.update_status(video, @status_error)
        {:error, error}
    end
  end
end
