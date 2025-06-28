defmodule VideoCompactor.InterfaceAdapters.Controllers.VideoController do
  require Logger
  alias VideoCompactor.InterfaceAdapters.DTOs.{VideoContentEventDTO, WebVideoResponseDTO}
  alias VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager, as: VideoManagerClient
  alias VideoCompactor.InterfaceAdapters.Repositories.VideoRepository
  alias VideoCompactor.UseCases.VideoCompactor
  alias InterfaceAdapters.Gateways.Clients.S3, as: S3Client

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
         {:ok, video} <- VideoContentEventDTO.to_domain(event_dto),
         :ok <- VideoCompactor.run(video, VideoRepository, VideoManagerClient, S3Client) do
      Logger.info("Video compacted with id: #{inspect(video.id)}")
      {:ok, %{}}
    else
      error ->
        Logger.error("Error managing video compacting: #{inspect(error)}")
        {:error, error}
    end
  end
end
