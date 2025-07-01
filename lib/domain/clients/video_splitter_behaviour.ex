defmodule VideoCompactor.Domain.Clients.VideoSplitterBehaviour do
  @callback split_video(String.t(), String.t()) :: :ok | {:error, String.t()}
end
