defmodule VideoCompactor.InterfaceAdapters.Controllers.VideoController do
  require Logger
  alias VideoCompactor.InterfaceAdapters.DTOs.VideoContentEventDTO
  alias VideoCompactor.UseCases.VideoCompactor

  def get_video_info(video_id) do
    Logger.info("Getting video info with id: #{inspect(video_id)}")

    {:ok, %{}}
  end

  def compact_video(raw_event) do
    Logger.info("Compacting video with id: #{inspect(raw_event)}")

    with {:ok, event_dto} <- VideoContentEventDTO.from_json(raw_event),
         file_path <- "#{event_dto.video_id}.#{event_dto.extension}",
         :ok <- File.write("/tmp/#{file_path}", event_dto.content),
         {:ok, video} <- VideoContentEventDTO.to_domain(event_dto, file_path),
         :ok <- VideoCompactor.run(video),
         :ok <- File.rm("/tmp/#{file_path}") do
      Logger.info("Video compacted with id: #{inspect(video.id)}")
      {:ok, %{}}
    else
      error ->
        Logger.error("Error managing video compacting: #{inspect(error)}")
        {:error, error}
    end
  end
end
