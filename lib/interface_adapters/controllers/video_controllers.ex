defmodule VideoCompactor.InterfaceAdapters.Controllers.VideoController do
  require Logger
  alias VideoCompactor.InterfaceAdapters.DTOs.{VideoContentEventDTO, WebVideoResponseDTO}
  alias VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager, as: VideoManagerClient
  alias VideoCompactor.InterfaceAdapters.Repositories.VideoRepository
  alias VideoCompactor.UseCases.VideoCompactor

  def get_video_info(video_id) do
    Logger.info("Getting video info with id: #{inspect(video_id)}")

    with {:ok, video} <- VideoRepository.get_by_id(video_id),
         {:ok, video_info} <- WebVideoResponseDTO.from_domain(video) do
      {:ok, video_info}
    else
      error ->
        Logger.error("Error getting video info: #{inspect(error)}")
        {:error, error}
    end
  end

  def compact_video(raw_event) do
    Logger.info("Compacting video with id: #{inspect(raw_event)}")

    with {:ok, event_dto} <- VideoContentEventDTO.from_json(raw_event),
         temp_file_path <- "#{event_dto.video_id}.#{event_dto.extension}",
         :ok <- File.write("/tmp/#{temp_file_path}", event_dto.content),
         {:ok, video} <- VideoContentEventDTO.to_domain(event_dto, temp_file_path),
         :ok <- VideoCompactor.run(video, VideoRepository, VideoManagerClient),
         :ok <- File.rm("/tmp/#{temp_file_path}") do
      Logger.info("Video compacted with id: #{inspect(video.id)}")
      {:ok, %{}}
    else
      error ->
        Logger.error("Error managing video compacting: #{inspect(error)}")
        {:error, error}
    end
  end
end
