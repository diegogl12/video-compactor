defmodule VideoCompactor.InterfaceAdapters.Gateways.Clients.VideoManager do
  @behaviour VideoCompactor.Domain.Clients.VideoManagerBehaviour

  @impl true
  def update_status(video, status) do
    params = [
      status: status,
      caminhoZip: video.zip_path
    ]

    client()
    |> Tesla.put("/api/Videos/status/#{video.id}", %{}, query: params)
    |> case do
      {:ok, %{status: status, body: _body}} when status >= 200 and status < 300 ->
        :ok

      {:ok, %{status: status, body: body}} ->
        {:error, "body: #{inspect(body)} status: #{inspect(status)}"}

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
