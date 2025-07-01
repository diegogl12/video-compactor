defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.S3 do
  @behaviour Domain.Clients.BucketBehaviour

  alias ExAws.S3

  @impl true
  def upload_file(bucket_path, local_path) do
    S3.put_object(get_bucket_name(), bucket_path, File.read!(local_path))
    |> ExAws.request()
    |> case do
      {:ok, _} ->
        :ok

      {:error, error} ->
        {:error, error}
    end
  end

  @impl true
  def download_file(bucket_path, local_path) do
    S3.download_file(get_bucket_name(), bucket_path, local_path)
    |> ExAws.request()
    |> case do
      {:ok, _} ->
        :ok

      {:error, error} ->
        {:error, error}
    end
  end

  @impl true
  def delete_file(_bucket_path) do
        :ok
  end

  defp get_bucket_name do
    Application.get_env(:video_compactor, :s3)[:bucket_name]
  end
end
