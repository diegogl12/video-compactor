defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager do
  @behaviour VideoCompactor.Domain.Clients.VideoManagerBehaviour

  @impl true
  def update_status(video, status) do
      client()
      |> Tesla.put("/video/status/#{video.id}", %{
        status: status,
        zip_path: video.zip_path
      })
    |> case do
      {:ok, %{status: status, body: _body}} when status >= 200 and status < 300 ->
        :ok

      {:ok, %{status: _status, body: body}} ->
        {:error, body}

      {:error, error} ->
        {:error, error}
    end
  end

  defp client do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, get_host()},
      {Tesla.Middleware.JSON, []}
    ])
  end

  defp get_host do
    Application.get_env(:video_compactor, :video_manager)[:host]
  end
end
