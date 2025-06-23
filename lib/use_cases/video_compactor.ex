defmodule VideoCompactor.UseCases.VideoCompactor do
  require Logger
  alias VideoCompactor.Domain.Entities.Video

  @zip_path "/tmp/zip"
  @tmp_path "/tmp"

  @spec run(any()) :: none()
  def run(%Video{} = video) do
    with charlist_path <- String.to_charlist("#{@tmp_path}/#{video.file_path}"),
         {:ok, zip_path} <- :zip.create("#{@zip_path}/#{video.id}.zip", [charlist_path]) do
      Logger.info("Zip path: #{inspect(zip_path)}")
      :ok
    else
      error ->
        Logger.error("Error compacting video: #{inspect(error)}")
        {:error, error}
    end
  end
end
