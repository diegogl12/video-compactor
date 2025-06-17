defmodule VideoCompactor.Domain.Clients.VideoManagerBehaviour do
  alias VideoCompactor.Domain.Entities.Video

  @callback update_status(Video.t(), String.t()) :: :ok | {:error, any()}
end
