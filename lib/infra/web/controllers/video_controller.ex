defmodule VideoCompactor.Infra.Web.Controllers.VideoController do
  require Logger

  alias VideoCompactor.InterfaceAdapters.Controllers.VideoController

  @doc """
    Gets the video info with the given id.

  params:
   - id: string
  """
  def get_video_info(id) do
    Logger.info("Getting video info with id: #{inspect(id)}")

    VideoController.get_video_info(id)
  end
end
