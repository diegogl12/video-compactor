defmodule VideoCompactor.InterfaceAdapters.Controllers.VideoController do
  require Logger

  def get_video_info(video_id) do
    Logger.info("Getting video info with id: #{inspect(video_id)}")

    {:ok, %{}}
  end

  def compact_video(video_id) do
    Logger.info("Compacting video with id: #{inspect(video_id)}")

    {:ok, %{}}
  end
end
