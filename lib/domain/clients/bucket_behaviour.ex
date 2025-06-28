defmodule Domain.Clients.BucketBehaviour do
  @callback upload_file(String.t(), String.t()) :: :ok | {:error, any()}
  @callback download_file(String.t(), String.t()) :: :ok | {:error, any()}
  @callback delete_file(String.t()) :: :ok | {:error, any()}
end
